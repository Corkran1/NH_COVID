Model Description
================

# Population

We present a spatial explicit stochastic agent based model that
recreates the day to day dynamics in a typical nursery home during the
COVID pandemic in the United States.

## Population Structure

We used the blueprints to recreate the spatial structure of a typical
nursery home in the US. The nursery home consist on 58 bedrooms
designated for the residents, recreation areas (such as dining room, and
activities rooms), and rooms for staff use.

In the initial conditions there are 3 residents per room (total 174) and
170 staff divided into 3 different turns. The decision on the population
distribution was based on information obtained from an interview with a
nursery home in California.

<img src="Figures/NH_B.png" width="400"/>

# Population Dynamics

In our simulation, an agent can interact with other agents based on its
location. Given the current guidelines of long term facilities, there
are no visitations and the residents spend most of the day in their
rooms, so they can only interact with their roommates and the staff. The
way staff interacts with the residents is based on the type of staff
(CN, RN, LPN), which have different contact rates that were parametrized
according on the average number of resident contacts in a normal day
(REFERENCE: Table shared via email??). The contact rates are presented
in table from supplementary materials.

| Type of staff | Distribution of resident contacts per turn |
| ------------- | ------------------------------------------ |
| CN            |                                            |
| RN            |                                            |
| LPN           |                                            |

\(x\sim109\)

# Transmission dynamics:

The Transmission probability inside the NH depends on the
*GlobalTransmission\_p*

Scenarios to explore:

  - Use of PPE: In this scenario there will be a proportion of staff
    using PPE, this staff will have a reduced *GlobalTransmission\_p*
    based on an assumption of the effect of the PPE in reducing the
    transmission.  
  - Reintroduction of the disease from hospitalizations.  
  - Introduction via patients that go outside for extra services
    (physical theraphy, etc.).  
  - 
## Incubation period

Table from paper by Park et al. \[@Park2020\]

| Author        | Sample Size  | Estimate (CI)  |
| :------------ | :----------- | :------------- |
| Li et al.     | 10 cases     | 5.2 (4.1. 7.0) |
| Backeret al.  | 88 cases     | 6.4 (5.6, 7.7) |
| Linton et al. | 158+52 cases | 5.6 (4.2, 6.3) |

## Pre symptomatic transmission

Infectiousness was observed \[@He2020\]:

  - 0.1% 7 days prior symptom onset.  
  - 1% 5 days prior symptoms onset.  
  - 9% 3 days prior symptom onset.

Infectiousness was estimated to decline quickly within 7 days.

# References
