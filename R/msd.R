#--------------
# Functions for the calculation of the MSD for transmission
# Credit and acknowledgement to W.N. (Bill) Venables who
# provided this code/solution

#' Used internally for calculating mean square displacement for transmission geometry
#'
#' @param x A number
#' @param y A number
#' @return A function localised in scope
msd_g1_diff <- local({
  lambda <- 6.32 / 1e+07
  L <- 0.01
  lstar <- z0 <- 0.000661
  k0 <- 2 * pi / lambda
  function(x, y) {
    ((((((L / lstar) + 4 / 3) / ((z0 / lstar) + 2 / 3)) * (sinh((z0 / lstar) * x) + (2 / 3) * x * cosh((z0 / lstar) * x))) / ((1 +
      (4 / 9) * x^2) * sinh((L / lstar) * x) + (4 / 3) * x * cosh((L / lstar) * x))) - y)
  }
})
#' Used internally for calculating mean square displacement for transmission geometry
#' @param y used internally to find root
#' @return The root value
#' @importFrom stats uniroot
findX <- function(y) {
  tst <- msd_g1_diff(c(.Machine$double.eps, 1), y)
  ## For 'uniroot' to behave properly, it's important that f(lower) * f(upper) < 0
  ## This test ensures that a solution is present to find X
  ## Otherwise, there is no root and thus NA
  if (prod(tst) < 0) {
    ## opposite signs
    stats::uniroot(msd_g1_diff, c(.Machine$double.eps, 1), y = y)$root
  } else {
    NA
  }
}
#' Used internally for calculating mean square displacement for transmission geometry
#' @param y used internally to find root
#' @return y as a vector
FindX <- Vectorize(findX)
#' Calculate the mean square displacement
#'
#' @param t_g1 A tibble consisting of correlation time, observed and scaled g1(t) values
#' @return A tibble consisting of correlation time and related mean square displacement
#' @donttest{
#' msd <- form_msd(g1)
#' }
#' @importFrom dplyr select
#' @importFrom stats na.omit
#' @export
form_msd <- function(t_g1) {
  lambda <- 6.32 / 1e+07
  k0 <- 2 * pi / lambda
  g1_msd <- within(t_g1, msd <- FindX(Scaled) / (10^8 * k0))
  g1_msd <- dplyr::select(g1_msd, -`Observed`, -`Scaled`)
  g1_msd <- stats::na.omit(g1_msd)
  ## Note : NAs are introduced in the 'findX' function (see above)
  ## This means that there is no 'uniroot' solution and thus deemed as NA
  ## The above statement is used as a filter for the NAs's
  return(g1_msd)
}
#' Plots the mean square displacement against the correlation time
#' @param g1_msd A tibble consisting of correlation time and related mean square displacement
#' @export
#' @importFrom ggplot2 ggplot aes geom_point scale_x_log10 scale_x_log10 labs
plot_msd <- function(g1_msd) {
  msd_p <- ggplot2::ggplot(g1_msd, ggplot2::aes(time, msd)) +
    ggplot2::geom_point() +
    ggplot2::scale_x_log10() +
    ggplot2::scale_y_log10() +
    ggplot2::labs(
      x = "Correlation time (s)",
      y = "Mean square displacement"
    )
  print(msd_p)
}
