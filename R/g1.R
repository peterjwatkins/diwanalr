#' Range scale a vector using the mean of first n elements as the maximum value
#'
#' @param y A vector
#' @param n An integer
#' @return A numeric vector
#' @examples
#' range_scale(Observed, 30)
range_scale <- function(y, n) {
    range <- mean(y[c(1:n)]) - min(y)
    return((y - min(y))/range)
}
#' Interpolate the scaled g1 vs time function and return fitted values
#'
#' @param d A tibble consisting of time and scaled g1(t) values
#' @return A numeric vector.
#' @examples
#' pred <- g1_spline(d)
g1_spline <- function(d) {
    spl <- with(d, smooth.spline(time, Scaled))
    pred <- with(d, predict(spl, time)$y)
    return(pred)
}
#' Calculates the autocorrelation function value (g1(t)) from measured correlation time and related intensity autocorrelation (g2(t))
#'
#' @param d A tibble consisting of measured correlation time and related intensity autocorrelation (g2(t)) value
#' @param n (optional) number of data points for scaling, default = 30
#' @return A tibble consisting of correlation time, calculated g1(t) and scaled g1(t)
#' @examples
#' e <- calc_g1(d, 30)
#' @export
#' @importFrom dplyr filter mutate select
calc_g1 <- function(d, n = NULL) {
  n <- ifelse(is.null(n), 30, n )
  d <- dplyr::filter(d, g2 >= 1)
  d <- dplyr::mutate(d, Observed = sqrt(g2 - 1))
  d <- dplyr::select(d, -g2)
  d <- dplyr::mutate(d, Scaled = range_scale(Observed, n))  # range scale data
  return(d)
}
#' Plots the scaled and observed g1(t)) against the correlation time, highlighting the point where g1(t) = 0.5
#'
#' @param d A tibble consisting of correlation time, calculated g1(t) and scaled g1(t)
#' @examples
#' plot_g1(d)
#' @export
#' @importFrom tidyr gather
#' @importFrom ggplot2 ggplot aes geom_point scale_x_log10 labs geom_hline geom_vline
plot_g1 <- function(d) {
    p <- g1_spline(d)
    t_half <- approxfun(x = p, y = d$time)(0.5)
    e <- tidyr::gather(d, key = g1, Value, -time)
    p <- ggplot2::ggplot(e, ggplot2::aes(time, Value, color = g1)) + 
      ggplot2::geom_point() + 
      ggplot2::scale_x_log10() + 
      ggplot2::labs(x = "Correlation time (s)", y = "g1(t)") +
      ggplot2::geom_hline(yintercept = 0.5, linetype = "dashed", color = "blue") + 
      ggplot2::geom_vline(xintercept = approxfun(x = p,
          y = d$time)(0.5), linetype = "dashed", color = "blue")
    return(p)
}
