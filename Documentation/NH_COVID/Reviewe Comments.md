# First round of revisions:
## Reviewer 1  
The study used agent-based modelling to simulate the transmission dynamics of COVID-19 in a nursing home in the US. The study reveals some interesting information about the operation and interactions between individuals in a nursing home. However, my main concerns are about the novelty of this study in terms of methods, results, and/or assisting decisions in policy making and some assumptions made to the model.  
  
- A review of literature on modelling COVID-19 in LTCFs is required. **How does this model differ from the existing models on the same topic? **  
*Interactions can vary *
- The choice of agent-based modelling was mentioned but not fully justified.   
  
- The modelling objectives were not clearly stated in the introduction and neither were the interventions tested (e.g. universal testing - is it for staff or residents or both?)  
  
- The agents' characteristics and decision rules should be described more explicitly. The **authors should consider using the ODD protocol** to document an agent-based model (Grimm et al, 2020; DOI: 10.18564/jasss.4259).   
  
- What is the **difference beween Exposed and Pre-symptomatic in the model?** Why was Pre-symptomatic mentioned in the manuscript but not shown in the transmission model.   
*Pre-symptomatic and exposed is the same in our model*
Just include pre-symptomatic and eliminate exposed, expand the distribution
  
- Most parameters characterising the disease progression were the same for both residents and staff (e.g. death rates, hospitalization rates, proportion of asymptomatic). Current evidence shows that these **parameters were age-specific and, therefore, would be greatly different between residents and staff.** Assuming that these parameters are the same for both is a strong assumption and would significantly affect the results. The authors need to **justify this assumption.**  
 *NEEDS TO BE IMPLEMENTED*, describe better the death rates and hospitalization, not enought support for asymptomatics
  
- Regarding the infection probability, is it per contact in no intervention scenario?   
*DON'T UNDERSTAND WHAT REVIEWER MEANS*
  
- It seems that the transmissibility of all infectious individuals is the same. However, Byambasuren et al (2020) suggest that the **transmissibility of asymptomatic people is much weaker.** (Byambasuren O, Cardona M, Bell K, Clark J, McLaws ML, Glasziou P. Estimating the extent of asymptomatic COVID-19 and its potential for community transmission: Systematic review and meta-analysis. J Assoc Med Microbiol Infect Dis Can. 2020;5:223-34.)  
- *NEEDS TO BE IMPLEMENTED*
  
- What is the **time step of the model** (hourly, every 8 hours, or daily)? Why is that specific time step chosen?  
*We included a sentence adding the time step used (line 82)*
  
- Regarding different types of staff, **how many staff members are there for each type?** 
*Added a sentence at line 114 for clarification of this*
  
- **How many staff members are on duty per shift?** Based on the description between lines 120 - 122, it seems that all of the 170 staff members come to work on one of the three shifts. If yes, it is **not a reasonable assumption as it will affect who got infected.** If no, that needs to be clarified. Additionally, it is likely that each type of staff will have different work schedules. If assuming the same work schedule, how this will affect the contact patterns and the results need to be discussed.   
  *DONT UNDERSTAND THIS*
   
- **Did the model assume no staff-staff contact?** If yes, it is a very strong assumption. Justification is required.  
*Contacts between staff happens based on the spatial location*
  
- A lot of residents in nursing homes have psychological and mental illness. It is challenging to keep them inside their room and stop them from having contacts with other residents. **Is it reasonable to assume no resident-resident contacts in this setting?**  
*The nursing home facility interviewed erported this, should we account for this comment somehow?*

- The vaccine efficacy used in the paper refers to the efficacy against symptomatic COVID-19. The vaccine efficacy against infection or transmission is not specified. How can the efficacy against disease be incorporated directly into the equation for transmission probability?  
*Given the information available at the time of writing, we assumed that the infection and transmission would have similar response. Should we make this different? papers to suport this assumptions?*

- How does vaccine affect the progression of the disease in terms of the probability of being symptomatic, hospitalisation, and death?  
*THis is a very relevant question, during the time of the model not enough vaccine information was available, this complex question is currently being investigated and was out of the scope of the paper at the time of writing due to the complexity and lack lack of information.
several factors as multiple vaccine dosease
It does not in our model, shoud we work on change this?*

- Lines 117, typo error? ("0.2 of two constants"?) Should be "contacts"?  
*typo corrected*
  
- Table 1, is the distribution for work schedule missing Xafternoon?  
  *Corrected* 
  
- Do the results between the different scenarios tested statistically differ? The statistical analysis should be explained in the methods.   
  
- The figure legends need to be clearer and allows audience understand without having to refer to the narrative. E.g., in Figure 2, what do the authors mean by "vaccine performance" and "equal".  
*We should change this, but for what?*
  
- The model assumes that residents are not replaced with new residents. Is it assumed that the nursing homes is closed to admission of new residents? As resident turnover in nursing homes is high and the simulated time is relatively long, justification for such a strong assumption is required.   
*This assumption was made based on the reported by the nursing home interviewed, should we make a different one?*
Usually high, but not during the pandemic. This would be a good scenario
  
  - The choice of sensitivity analysis scenarios needs to be explained and/or referenced. Also, why are some parameters included and some excluded from the sensitivity analysis?  
  *GSA could be an option for making a more torough sensitivity analysis*
  
- How is the model validated? Some approaches have been mentioned but the validation needs to explicitly explained.  
  *validation vs calibration, how can we differentiate this?*
  
Reviewer 2  
The manuscript describes a modeling study of the effect of interventions and community prevalence on outcomes within nursing homes. The study does a good job of considering the various factors at play, though there are several limitations. My main concern is with possible over interpretation of one of the results. Other concerns are also significant, and addressing them will help readers find relevance in this study and be able to reproduce and/or build on the described work.  
  
Major Comments:  

- L197:199: "When vaccine was prioritized among staff, residents, or both, the attack did not seem to differ except when the introduction probability was high, in which case the simulated median attack rate was 0.02 when staff were prioritized compared to 0.03 if residents were prioritized or no prioritization was present." Please provide 95% CIs for these medians. If the CIs overlap (as it appears that they do, and quite broadly, in table S2), then our confidence that these prioritization strategies differ in their effect on attack rate must be tempered. This should be reflected in the language used in the abstract on L26-27. Furthermore, table S1 shows that **vaccine prioritization is very simple, with a 30/70 split in vaccine coverage prioritizing either staff or residents as 70% vaccinated. The authors likely agree that a more valuable comparison would be to independently vary Vr and Vs so that the effect of staff vs resident vaccination can be evaluated without conflating the two, though I don't necessarily recommend that the authors go through these simulations (given the amount of time that would take) unless they are otherwise compelled to do so**. Instead, I recommend that extreme care be taken in the interpretation of this result. Explaining the prioritization strategies in the text would be very helpful for readers.  
**
  
Minor comments:  

- L26-27 "Vaccine prioritization of staff provides the best protection strategy when the risk of viral introduction is high" I'm not sure that this claim is supported by the study, given the reporting in its current state. See comments on L197-199.  

- L35-36: Given that the national average is approximately a 2:1 resident - to - staff ratio, why did the authors use a ~1:1 ratio? Support for this ratio should be stated in the methods.  
*This was based on the information provided by the nursing facility interviewed*

- L44: incredible may not be the best choice of words. Also, it would be best to explain with more exact language what the authors mean by "magic solution". E.g., "other studies have demonstrated that adherence to non-vaccine intervention measures plays a strong role in reducing infectious disease burden even following vaccine rollout" or something similar that expresses the authors intentions more directly.  


- L48-64: The statistics for vaccine coverage are now quite out of date, as are the statements about nursing home visitation policies in many places. We also, of course, now know quite a bit more about the effects of vaccines on susceptibility, transmission, and progression to disease. I commiserate with the authors that, likely due to a slow publication or review process combined with rapidly changing real-world environment, it is difficult for many published manuscripts to retain full applied value by the time they are eventually published. Still, it may be good to include some description of the present situation, while still providing the background situation under which the model was created and parameterized. This should help future readers appropriately contextualize your work.  
L93-95: Generally, there is a latent period after infection but before infectiousness. My interpretation from these lines is that the authors specified latent infections as infectious, but in the following sentence, the authors state that only asymptomatic and symptomatic classes are infectious. I recommend the authors refine their language for clarity.  
L111-113: Do the authors believe that the described assumption of no resident-to-resident contact outside of roommates is realistic? If so, please provide citations in support. If not, this should be discussed at some point in the paper, possibly as a limitation or an area of recommended future extension of the model.  
L114-124: This is a very nice implementation of staff scheduling and contact. One question: Does each staff type make random resident contacts each day, or does a given resident see a certain staff type more consistently than another staff type? It will be helpful to the reader to specify this. I see that this topic is touched on in the strengths and limitations sections, but it would help to describe it in the methods to give the reader a full understanding of the model prior to seeing the results.  
L 165-166: When residents test positive, do they still have contact with staff?  
L182-183: Please indicate the specific statistical tests used (I see multiple linear regression and mixed-effects multiple regression in the supplemental validation code, but this should be indicated here).  
L187-190: please give 95%CIs for attack rate and time to eradication.  
L229-232 citations would be helpful  
L255-256: interesting idea about expanding paid leave programs - citations would help guide readers to relevant literature.