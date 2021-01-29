/**
* Name: NH01
* Based on the internal empty template. 
* Author: jpablo91
* Tags: 
*/

/*
 * Notes:
 * Improve the hospitalization part, have a look at the Yolo dashboad https://www.yolocounty.org/health-human-services/adults/communicable-disease-investigation-and-control/novel-coronavirus-2019/dashboard-and-documents
 * 
 */

model NH01
import 'Parameters.gaml'
import "species/Sp.gaml"
import "species/Interventions.gaml"

global{
	// Main settings:
	bool ExportResults <- true;
	float seed <- int(self) + 1.0;
	int SimLength <- 150*24; //120 days
	int Days_free;

	float step <- 1#hour;
	int Day_hour;
	// load files
	file building_shp <- file("../includes/nh_building.shp");
	file rooms_shp <- file("../includes/nh_rooms.shp");
	file community_shp <- file("../includes/community.shp");
	file envelope_shp <- file("../includes/Envelope.shp");
	
	geometry shape <- envelope(geometry(envelope_shp));
	
	// Staff parameters
	string Schedule;
	int Total_Staff <- 170; // Total number of staff
	int Total_Residents <- 0 update: Residents count(each.is_infected or !each.is_infected);
	map<int, float> TurnsDistribution <- ([1::0.4, 2::0.4, 3::0.2]); // Distribution of staff for each turn [Morning, Afternoon, Night]
	map<string, float> StaffDistribution <- ['CN'::0.6, 'LPN'::0.15, 'RN'::0.15, 'PT'::0.0]; // Distribution of staff by type [CN, LPN, RN, PT]
	map<int, float> PPH_CN <- ([0::0.7, 1::0.3]); // Distribution of patients per hour for CN
	map<int, float> PPH_RN <- ([0::0.25, 1::0.75]); // Distribution of patients per hour for RN
	map<int, float> PPH_LPN <- ([0::0.15, 1::0.05, 2::0.2, 3::0.2, 4::0.2, 5::0.2]); // Distribution of patients per hour for LPN
	
	
	 bool RecreationRestrictions;
	 bool CD_Restriction;
	
	//Disease parameters
	int InitialInfected <- 1;
	float infection_distance <- 1.5#m;
//	float GlobalTransmission_p <- 0.0;
	float Hosp_rate <- 0.11;
	float Res_Hospitalization <- 0.15/(24*5); // 
//	float Res_Hospitalization <- 0.108/(24*5); //
	int Infection_Duration <- 15;
	
	// Disease outcomes
	int S_r <- 0 update: Residents count (each.is_susceptible);
	int I_r <- 0 update: Residents count (each.is_infectious);
	int E_r <- 0 update: Residents count (each.is_infected);
	int H <- 0 update: Residents count (each.is_hospitalized);
	int S_s <- 0 update: Staff count (each.is_susceptible);
	int I_s <- 0 update: Staff count (each.is_infectious);
	int E_s <- 0 update: Staff count (each.is_infected);
	int I <- 0 update: I_r + I_s; // Total Infected
	int E <- 0 update: E_r + E_s; // Total Exposed
	
	int Cumulative_I;
	int Cumulative_I_r;
	int Cumulative_I_s;
	int Cumulative_H;
	
	// ~~~~~~~~~~~~~~~~~~~ || INTERVENTIONS || ~~~~~~~~~~~~~~~~~~~~	
	bool ActiveSurv;
	bool PassiveSurv;
	bool R_Testing;
	bool S_Testing;
	bool Resident_Vaccination;
	bool Staff_Vaccination;
	// ~~~~~~PPE USE~~~~~~~
	bool PPE_Use;
	float PPE_effect <- 0.0;
	// ~~~~~~Vaccination~~~~~
	float Vaccine_effect <- 0.0;
	int vaccination_freq <- 90; // when should another vaccination happen?
	
	
	
//	float Vi_first_dose <- 0.6 parameter: "First Dose Immunity";
//	float Vi_second_dose <- 0.9 parameter: "Second Dose Immunity";
//	int Immunity_decay_t <- 110 parameter: "Time to vaccination decay";
	int Revaccination_t <- 21 parameter: "Time to revaccination (second dose)";
//	float G_Rise <- 0.4/step parameter: "Rate of Immunity rise";
//	float G_Decay <- 0.001/step parameter: "Rate of Immunity Decay";
	
	// initial conditions
	init{
		// Set the interventions according to scenarios
		// Baseline conditions:
		RecreationRestrictions <- true;
		CD_Restriction <- true;
		ActiveSurv <- true;
		S_Testing <- true;
		R_Testing <- true;
		PPE_Use <- true;
		
		if Scenario = 1{
			Vaccination_OR_S <- 0.0434;
			Vaccination_OR_R <- 0.0619;
		}
		if Scenario = 2{
			Vaccination_OR_S <- 0.0441;
			Vaccination_OR_R <- 0.1357;
		}
		
		create Building from: building_shp;
		create Interventions;
		// Create the Rooms with residents
		create Rooms from: rooms_shp{
			if Type = "Bedroom"{
				create Residents number:3{
					My_Vaccine_OR <- Vaccination_OR_R;
					my_bedroom <- myself;
					current_room <- myself;
					location <- any_location_in(geometry(community_shp));	
					hospitalization_p <- Res_Hospitalization;
					add self to: myself.CurrentRes;
					// PPE
					if flip(p_PPE_res){
						x_PPE <- 1;
//						transmission_p <- GlobalTransmission_p * (1-PPE_effect);
//						shedding_p <- GlobalShedding_p * (1-PPE_effect);
//						infection_p <- GlobalInfection_p * (1-PPE_effect);
						PPE_e <- 1-PPE_effect;
						
					}else{
						x_PPE <- 0;
						PPE_e <- 1.0;
//						transmission_p <- GlobalTransmission_p;
//						shedding_p <- GlobalShedding_p;
//						infection_p <- GlobalInfection_p;
					}
//					// Initial Vaccination
//					if flip(p_vaccination_res){
//						is_vaccinated <- true;
//						Vaccine_e <- 1-Vi_first_dose;
//						x_Vaccine <- First_dose_effect;
////						transmission_p <- GlobalTransmission_p * (1-Vaccine_effect);
////						shedding_p <- GlobalShedding_p * (1-Vaccine_effect);
////						infection_p <- GlobalInfection_p * (1-Vaccine_effect);
//					}
				}
			}
		}
		// Create the staff
		// one for each schedule:
		create Staff number: Total_Staff{
			My_Vaccine_OR <- Vaccination_OR_S;
			schedule <- rnd_choice(TurnsDistribution);
			Type <- rnd_choice(StaffDistribution);
			current_room <- one_of(Rooms where(each.Type = "Staff"));
			location <- any_location_in(current_room);
			// Define transmission probability based on the type of staff:
			if Type = 'CN'{
//				transmission_p <- GlobalTransmission_p*0.8;
				shedding_p <- GlobalShedding_p * 0.8;
				infection_p <- GlobalInfection_p * 0.8;
			} else if Type = 'LPN'{
//				transmission_p <- GlobalTransmission_p*0.6;
				shedding_p <- GlobalShedding_p * 0.6;
				infection_p <- GlobalInfection_p * 0.6;
			}else if Type = 'RN'{
//				transmission_p <- GlobalTransmission_p*0.4;
				shedding_p <- GlobalShedding_p * 0.4;
				infection_p <- GlobalInfection_p * 0.4;
			}
			
			if flip(p_PPE_staff){
				x_PPE <- 1;
				PPE_e <- 1-PPE_effect;
//				transmission_p <- GlobalTransmission_p * (1-PPE_effect);
					}else{
						x_PPE <- 0;
						PPE_e <- 1.0;
//						transmission_p <- GlobalTransmission_p;
					}
					// Initial Vaccination
//					if flip(p_vaccination_staff){
//						is_vaccinated <- true;
//						transmission_p <- transmission_p * (1-Vaccine_effect);
//						shedding_p <- GlobalShedding_p * (1-Vaccine_effect);
//						infection_p <- GlobalInfection_p * (1-Vaccine_effect);
//					}
		}
		

		write 'Morning Staff N; ' + Staff count (each.schedule = 1);
		write 'Afternoon Staff N; ' + Staff count (each.schedule = 2);
		write 'Evening Staff N; ' + Staff count (each.schedule = 3);
		write '--------------------------';
//		write "mean latent period:" + Residents mean_of(each.Alatent_period) + "(" + Residents min_of(each.Alatent_period) + "," + Residents max_of(each.Alatent_period);
	}
	
	reflex Write_time{
//		write "Time: " + current_date;
		Schedule <- current_date.hour between(6,9) ? "Eating Time" : 
		(current_date.hour between(8, 12) ? "Recreation Time" : 
		(current_date.hour between(11, 13) ? "Eating Time" :
		(current_date.hour between(12, 19) ? "Recreation Time" : 
		(current_date.hour between(18, 21) ? "Eating Time" :"Quiet Hours"))));	
//		write Schedule;
	}
	
	
	reflex init_outbreak when: cycle = 24{
		ask InitialInfected among (Residents){
			is_susceptible <- false;
			is_infected <- true;
			max_hosp_days <- poisson(8); // how many days will the resident spend in hospital? (if hospitalized)
		}
	}
	
	reflex SaveResults when: ExportResults{
		save [cycle, I, E, S_r, I_r, I_s, E_s, H, Cumulative_I_r, Cumulative_I_s, Cumulative_H] to: "../results/" + "/EC/EpiCurve" + int(self) +".csv" type:"csv" rewrite:false;
	}
	
	reflex StopSim when:cycle > SimLength{
		do pause;
	}
	
	reflex DieOff when: (E_r + I_r + E_s + I_s) = 0{
//		bool OutbreakEnded;
		Days_free <- Days_free + 1;
//		write 'E: ' + E_r + '||  I:' + I_r;
		if Days_free > 24*7{
//			OutbreakEnded <- true;
			write "Outbreak ended at:" + cycle;	
		}
	}

}

/* Insert your model definition here */

