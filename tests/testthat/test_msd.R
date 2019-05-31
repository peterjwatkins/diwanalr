context("testing msd functions")

library("testthat")
# Form test set
span <- seq(-8, 1, 0.05)
time <- 10 ^ span
t_half <- 0.001

g1 <- exp(-2 * sqrt(6 * time / t_half))
g2 <- 1 + 0.9 * g1 ^ 2
test <- tibble::as_tibble(cbind(time, g2))

g1_test <- form_g1(test)

test_that("calc_msd tibble", {
  expect_is(form_msd(g1_test),  "data.frame")
})

## First numbers of model dataset do not pass
test_that("calc_msd fails", {
  identical(NA, form_msd(g1_test[1:10, ]))
})

# Sample testing
## Check test calculation - msd = 5.05e-18
test_that("calc_msd test solution", {
  expect_equal(form_msd(g1_test[18, ])$msd, 5.0e-18, tolerance = 1e-19)
})

## Check test calculation - msd = 7.76e-17
test_that("calc_msd test solution", {
  expect_equal(form_msd(g1_test[52, ])$msd, 7.7e-17, tolerance = 1e-18)
})

##Check test calculation - msd = 4.53e-16
test_that("calc_msd test solution", {
  expect_equal(form_msd(g1_test[100, ])$msd, 4.5e-16, tolerance = 1e-17)
})

## Check object length
test_that("calc_modulus test", {
  expect_length(form_msd(g1_test), 2)
})