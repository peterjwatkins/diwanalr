context("testing msd")

library("testthat")

#d <- calc_g1(dws)

test_that("calc_msd returns df", {
  expect_is(calc_msd(calc_g1(dws)), "data.frame")
    }
)

test_that("plot_msd returns ggplot object",{
  p <- plot_msd(calc_msd(calc_g1(dws)))
  expect_is(p,"ggplot")
})
