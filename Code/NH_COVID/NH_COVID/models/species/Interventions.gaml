/**
* Name: Interventions
* Based on the internal empty template. 
* Author: jpablo91
* Tags: 
*/

@no_experiment

model Interventions

import "../global.gaml"
import "../global.gaml"

species Interventions{
	list<People> Infected_People <- [] update: (agents of_generic_species People where each.is_infectious);
	bool active;
	
	// Active surveillance
	action ActiveSurveillance{
		// Resident testing
		if R_Testing and every(TestingFreq*24#cycle){ // test the residents every week
			ask Rooms where(each.Type = "Bedroom" and (length(each.CurrentRes) > 0)){
				Residents t_resident <- one_of(CurrentRes where(!each.hospitalized));
				if flip(Test_sensitivity) and t_resident.is_infected{
					t_resident.detected <- true;
					// If one of the residents positive, test the roomates.
					ask CurrentRes{
						if flip(Test_sensitivity) and is_infected{
							detected <- true;
						}
					}
				}
//				write 'tested at day: ' + cycle/24;
			}
		}
		
		// Staff testing 
		if S_Testing and every(TestingFreq*24#cycle){
			ask (Staff where !each.tested){
				if flip(Test_sensitivity) and is_infected{
					detected <- true;
					do die; // remove the staff member for now
					}
				}
		}
	}
	
	// Passive surveillance (Targeted)
	action PassiveSurveillance{
		list<Residents> ASR <- Residents where(each.detected and each.is_symptomatic);
		if length(ASR) > 0 {
			ask one_of(ASR){
				if flip(Test_sensitivity) and is_infected{
					detected <- true;
				}
			}
			
		}
	}
	
	action Isolation{
		if length(Residents where(each.detected and !each.is_isolated)) > 0 {
			ask one_of(Residents where(each.detected and !each.is_isolated)){
				my_bedroom.CurrentRes >- self; // remove self
				Rooms q_room <- one_of(Rooms where(each.Type = "PrivateBedroom"));
				my_bedroom <- q_room;
				current_room <- my_bedroom;
				self.location <- q_room.location;
				is_isolated <- true;
				}			
		}
		
	}
	
	action Vaccination{
		// Staff vaccination
		ask floor(p_vaccination_staff*Total_Staff) among Staff where(!each.is_vaccinated){
			is_vaccinated <- true;
			vaccinated_days <- 0;
//			Vaccine_e <- Vi_first_dose;
			x_Vaccine <- 0.6;
//			shedding_p <- shedding_p * (1-Vaccine_effect);
//			infection_p <- infection_p * (1-Vaccine_effect);
		}
		
		// Resident vaccination
		ask floor(p_vaccination_res*Total_Residents) among Residents where(!each.is_vaccinated){
			is_vaccinated <- true;
			vaccinated_days <- 0;
//			Vaccine_e <- Vi_first_dose;
			x_Vaccine <- 0.6;
//			shedding_p <- shedding_p * (1-Vaccine_effect);
//			infection_p <- infection_p * (1-Vaccine_effect);
		}
	}
	
	reflex StartVaccination when: (every(80*24#cycle)){
		do Vaccination;
		write "------------------";
		write "Vaccination at:" + cycle;
		write "Residents: " + floor(p_vaccination_res*Total_Residents) ;
		write "Staff: " + floor(p_vaccination_staff*Total_Staff) ;
		write "------------------";
	}
	
	reflex interventions{
		active <- true;
//		write "~~~~~~~~~~~~~~~~~~~";
//		write 'intervention is on';
//		write "~~~~~~~~~~~~~~~~~~~";
		do ActiveSurveillance;
		if(length(Infected_People) > 0){
			do PassiveSurveillance;
			do Isolation;
		}
	}
}

/* Insert your model definition here */

