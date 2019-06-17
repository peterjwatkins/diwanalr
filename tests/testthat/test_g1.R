context("testing g1")

library("testthat")

# Form test set
span <- seq(-8, 1, 0.05)
time <- 10 ^ span
t_half <- 0.001
g1 <- exp(-2 * sqrt(6 * time / t_half))
g2 <- 1 + 0.9 * g1 ^ 2
test <- tibble::as_tibble(cbind(time, g2))

g1_test <- form_g1(test)

test_that("form_g1 returns df", {
  expect_is(form_g1(test), "data.frame")
})

test_that("Low time value returns appropriate g1(t) result", {
  expect_equal(g1_test[30,]$Scaled,
               1.00, tolerance = 0.05)
})

test_that("High time value returns appropriate g1(t) result", {
  expect_equal(g1_test[nrow(g1_test)-20,]$Scaled,
               0.00, tolerance = 0.05)
})

#test_that("Low time value returns appropriate g1(t) result", {
#  expect_equal(sqrt((1 + 0.9 * exp(
#    -2 * sqrt(6 * 10 ^ -8 / 0.05)
#  ) ^ 2) - 1),
#  0.95, tolerance = 1e-2)
#})

#test_that("High time value returns appropriate g1(t) result", {
#  expect_equal(sqrt((1 + exp(
#    -2 * sqrt(6 * 10 ^ 3 / 0.05)
#  )) - 1), 0.000, tolerance = 1e-2)
#})
