context("testing msd functions")

library("testthat")

g1_t <- form_g1(dws) ; g1_msd <- form_msd(g1_t)

test_that("calc_msd tibble", {
  expect_is(form_msd(g1_t),  "data.frame") 
}
)