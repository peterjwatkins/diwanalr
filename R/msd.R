#--------------
# Functions for the calculation of the MSD for transmission 
# Credit and acknowledgement to W.N. (Bill) Venables who
# provided this code/solution

#' Used internally for calculating mean square displacement for transmission geometry
#'
msd_g1_diff <- local({
    lambda <- 6.32/1e+07
    L <- 0.01
    lstar <- z0 <- 0.000661
    k0 <- 2 * pi/lambda
    function(x, y) {
        ((((((L/lstar) + 4/3)/((z0/lstar) + 2/3)) * (sinh((z0/lstar) * x) + (2/3) * x * cosh((z0/lstar) * x)))/((1 +
            (4/9) * x^2) * sinh((L/lstar) * x) + (4/3) * x * cosh((L/lstar) * x))) - y)
    }
})
#' Used internally for calculating mean square displacement for transmission geometry
#'
findX <- function(y) {
    tst <- msd_g1_diff(c(.Machine$double.eps, 1), y)
    if (prod(tst) < 0) {
        ## opposite signs
        uniroot(msd_g1_diff, c(.Machine$double.eps, 1), y = y)$root
    } else NA
}
#' Used internally for calculating mean square displacement for transmission geometry
#'
FindX <- Vectorize(findX)
#' Calculate the mean square displacement
#'
#' @param d A tibble consisting of correlation time, observed and scaled g1(t) values
#' @return A tibble consisting of correlation time and related mean square displacement
#' @examples
#' e <- calc_msd(d)
#' @importFrom dplyr select
calc_msd <- function(d) {
    lambda <- 6.32/1e+07
    k0 <- 2 * pi/lambda
    e <- within(d, msd <- FindX(Scaled)/(10^8 * k0))
    e <- dplyr::select(e, -`Observed`, -`Scaled`)
    e <- na.omit(e)
#    print(e)
    return(e)
}
#' Plots the mean square displacement against the correlation time
#' @param g A tibble consisting of correlation time and related mean square displacement
#' @examples
#' plot_msd(e)
#' @export
#' @importFrom ggplot2 ggplot aes geom_point scale_x_log10 scale_x_log10 labs
plot_msd <- function(d) {
    p <- ggplot2::ggplot(d, ggplot2::aes(time, msd)) + 
      ggplot2::geom_point() + 
      ggplot2::scale_x_log10() + 
      ggplot2::scale_y_log10() + 
      ggplot2::labs(x = "Correlation time (s)",
        y = "Mean square displacement")
    return(p)
}
