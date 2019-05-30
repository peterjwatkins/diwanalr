context("testing g1")

library("testthat")

test_that("form_g1 returns df", {
  expect_is(form_g1(dws), "data.frame")
})

test_that("Low time value returns appropriate g1(t) result", {
  expect_equal(
    sqrt((1 + 0.9*exp(-2*sqrt(6*10^-8/0.05))^2)-1),
    0.95, tolerance=1e-2)
})

test_that("High time value returns appropriate g1(t) result", {
  expect_equal(sqrt((1+ exp(-2*sqrt(6*10^3/0.05)))-1), 0.000, tolerance=1e-2)
})

