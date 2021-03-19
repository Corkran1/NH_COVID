##### Data description ####
# The data contains a time series for observed and simulated outbreaks in nursery homes facilities. 
# Variables used are:
# - day, day since the beginning of the oubreak
# - CumI, cumulative number of infected.
# - type, if its an observed or simulated outbreak
# - Ir_cumsum, cumulative number of resident cases
# - Is_cumsum, cumulative number of staff cases
# - Sim, Id of the outbreak


#### Load the data and packages used ####
# packages
# if not installed run:
install.packages(c('dplyr', 'MuMIn', 'lme4'))
library(dplyr); library(MuMIn); library(lme4)
# data:
d <- read.csv("O_E.csv")

##### Using R^2 in a lm model ####
# Using the cumulative infected (residents+staff)
d %>% # here is the data
  lm(formula = CumI~type + day + Sim, data = .) %>% # model specification
  summary() %>% # obtain a summary
  .$r.squared # get the R^2
# Using only cumulative residents
d %>%
  lm(formula = Ir_cumsum~type + day + Sim, data = .) %>%
  summary() %>%
  .$r.squared
# Using only cumulative staff
d %>%
  lm(formula = Is_cumsum~type + day + Sim, data = .) %>%
  summary() %>%
  .$r.squared

#### Using a LMM with the proposed R^2 approximation ####
# R2m (Marginal R^2) represents the variance explained by the fixed effects
# R2c (Conditional R^2) represents the variance explained by the random effect.
# Does small R2m means that the covariate is not relevant (a.k.a there is no difference, our model produces good estimates to the observed??)

# Using Res+Staff
d %>%
  lme4::lmer(formula = CumI~type + (1 + day|Sim), data = .) %>% # model specification
  MuMIn::r.squaredGLMM(.) # Get R^2 using the method from the paper
# Only Res
d %>%
  lme4::lmer(formula = Ir_cumsum~type + (1 + day|Sim), data = .) %>% 
  MuMIn::r.squaredGLMM(.)
# Only Staff
d %>%
  lme4::lmer(formula = Is_cumsum~type + (1 + day|Sim), data = .) %>% 
  MuMIn::r.squaredGLMM(.)