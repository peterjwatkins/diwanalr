context("testing g1")

library("testthat")

g1 <- form_g1(dws) ; msd <- form_msd(g1)

test_that("calc_modulus returns tibble", {
  expect_is(form_modulus(msd),  "data.frame") 
}
)

test_that("calc_modulus returns tibble", {
  expect_is(calc_modulus(e),  "tibble") 
}
)