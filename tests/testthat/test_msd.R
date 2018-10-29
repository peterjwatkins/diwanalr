context("testing msd functions")

library("testthat")

g1_t <- form_g1(dws) ; g1_msd <- calc_msd(g1_t)

test_that("calc_msd tibble", {
  expect_is(calc_msd(g1_t),  "data.frame") 
}
)

test_that("calc_modulus returns tibble", {
  expect_is(calc_modulus(e),  "tibble") 
}
)