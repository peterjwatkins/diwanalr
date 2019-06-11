context("testing modulus functions")

library("testthat")
# Form test set
span <- seq(-8, 1, 0.05)
time <- 10 ^ span
t_half <- 0.001
g1 <- exp(-2 * sqrt(6 * time / t_half))
g2 <- 1 + 0.9 * g1 ^ 2
test <- tibble::as_tibble(cbind(time, g2))

g1_test <- form_g1(test)
msd_test <- form_msd(g1_test)

test_that("calc_modulus returns data frame
", {
  expect_is(form_modulus(msd_test), "data.frame")
})

##Check test calculation -
test_that("calc_modulus test", {
  expect_equal(form_modulus(msd_test[20:22, ])$`Storage (G')`[1], 53.0, tolerance = 0.1)
})

test_that("calc_modulus test", {
  expect_equal(form_modulus(msd_test[20:22, ])$`Loss (G'')`[1], 34.5, tolerance = 0.1)
})

test_that("calc_modulus test", {
  expect_equal(form_modulus(msd_test[80:82, ])$`Storage (G')`[1], 5.8, tolerance = 0.1)
})

test_that("calc_modulus test", {
  expect_equal(form_modulus(msd_test[80:82, ])$`Loss (G'')`[1], 3.8, tolerance = 0.1)
})
## Check magnitude of answer
test_that("calc_modulus test", {
  expect_gt(form_modulus(msd_test[20:22, ])$`Storage (G')`[1], 5.8)
})

test_that("calc_modulus test", {
  expect_gt(form_modulus(msd_test[20:22, ])$`Loss (G'')`[1], 3.8)
})

# Check okject length
test_that("calc_modulus test", {
  expect_length(form_modulus(msd_test[20:82, ]), 3)
})
