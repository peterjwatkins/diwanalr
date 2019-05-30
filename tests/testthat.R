library(testthat)
library(diwanalr)

test_check("diwanalr")
## Test performed on the calculations use model data.

# The model response is taken from:
# Coarsening and Rheology of Casein and Surfactant Foams
# A. Saint-Jalmes, S. Marze and D. Langevin
# Equations 4 and 5, page 276
# Food Colloids: Interactions, Microstructure and Processing
# ed. by Eric Dickinson
# g2(t) ~ 1 + beta*g1(t)^2
# g1(t) ~ exp(-2*sqrt(6*t/tm)) and

# -------- R code to produce model data
# span <- seq(-8, 1, 0.05) ; time <- 10^span
# t_half <- 0.05
# g2 <- exp(-2*sqrt(6*time/t_half))
# g1 <- 1 + 0.9*g2^2
# test <- tibble::as_tibble(cbind(time, g2))