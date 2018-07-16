context("testing g1")

library("testthat")

test_that("calc_g1 returns df", {
  expect_is(calc_g1(dws),  "data.frame") 
}
)

test_that("plot_g1 returns ggplot object",{
  p <- plot_g1(calc_g1(dws))
  expect_is(p,"ggplot")
})