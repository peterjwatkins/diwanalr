context("testing g1")

library("testthat")

d <- calc_g1(dws) ; e <- calc_msd(d)

test_that("calc_modulus returns tibble", {
  expect_is(calc_modulus(e),  "data.frame") 
}
)

test_that("calc_modulus returns tibble", {
  expect_is(calc_modulus(e),  "tibble") 
}
)