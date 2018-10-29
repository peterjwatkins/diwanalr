context("testing g1")

library("testthat")

test_that("form_g1 returns df", {
  expect_is(form_g1(dws),  "data.frame") 
}
)