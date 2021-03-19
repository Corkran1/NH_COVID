/**
* Name: Parameters (Medium Introduction, Equal distribution scenario)
* Parameters for the model
* Author: jpablo91
* Tags: 
*/

/*
 * ===========| Medium Introduction, Equal distribution |=================
 */

model Parameters
global{
	/*======| Scenarios: |==========
	 * 0 = Baseline
	 * 1 = Vaccine effect according to @B202
	 * 2 = Vaccine effect according to @Polack202
	 */
	 int Scenario <- 2;
	 
	 
	 // ===========| Disease Parameters |=========
	 float GlobalShedding_p <- 0.40; // Baseline 0.5(0.3, 0.7)
	 float GlobalInfection_p <- GlobalShedding_p; // Baseline 0.5(0.3, 0.7)
	 float Asymptomatic_p <- 0.4; // Basleine 0.25
	 float Introduction_p <- 0.1; // Baseline 0.01(0.05, 0.1)
	 float Res_Hospitalization <- 0.23/(24*5); // 
	 float BaseMortality <- 0.118;
	 
	 // ~~~~~~~~~~~~~~~~~~~ || INTERVENTIONS || ~~~~~~~~~~~~~~~~~~~~	
	 int TestingFreq <- 7; // 7(3, 5)
	 float Test_sensitivity <- 0.8; // Detection probability 0.75(0.85, 0.95)
	 // ~~~~~~PPE USE~~~~~~~
	 float PPE_OR <- 0.1467; // Odds ratio for the use of PPE  0.1467(0.0722, 0.3408)
	 float p_PPE_res <- 0.75;
	 float p_PPE_staff <- 0.9;
	 // ~~~~~~Vaccination~~~~~
   float Vaccination_OR_S <- 0.0441; // (M=0.0441, P=0.0434)
	 float Vaccination_OR_R <- 0.1357; //(M=0.1357, P=0.0619)
	 float p_vaccination_res <- 0.3;
	 float p_vaccination_staff <- 0.7;
	 int Vaccination_decay <- 120*24;
	 float First_dose_effect <- 0.6; // the first dose effect will be scaled by this constant.
	
	
}