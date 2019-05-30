context("testing g1")

library("testthat")

g1 <- form_g1(dws)
msd_t <- form_msd(g1)
mod_test <- form_modulus(msd_t)
test_that("calc_modulus returns tibble", {
  expect_is(form_modulus(msd_t), "data.frame")
})
