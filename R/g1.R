#' Range scale a vector using the mean of first n elements (num_points) as the maximum value
#'
#' @param vec A vector
#' @param num_points An integer
#' @return A numeric vector
range_scale <- function(vec, num_points) {
  range <- mean(vec[c(1:num_points)]) - min(vec)
  return((vec - min(vec)) / range)
}
#' Interpolate the scaled g1 vs time function and return fitted values
#'
#' @param t_g1 A tibble consisting of time and scaled g1(t) values
#' @return A numeric vector.
g1_spline <- function(t_g1) {
  spl_model <- with(t_g1, smooth.spline(time, Scaled))
  pred_values <- with(t_g1, predict(spl_model, time)$y)
  return(pred_values)
}
#' Calculates the autocorrelation function value (g1(t)) from measured correlation time and related intensity autocorrelation (g2(t))
#'
#' @param t_g2 A tibble consisting of measured correlation time and related intensity autocorrelation (g2(t)) value
#' @param num_points (optional) number of data points for scaling, default = 30
#' @return A tibble consisting of correlation time, calculated g1(t) and scaled g1(t)
#' @export
#' @importFrom dplyr filter mutate select
form_g1 <- function(t_g2, num_points = NULL) {
  num_points <- ifelse(is.null(num_points), 30, num_points)
  t_g2 <- dplyr::filter(t_g2, g2 >= 1)
  t_g1 <- dplyr::mutate(t_g2, Observed = sqrt(g2 - 1))
  t_g1 <- dplyr::select(t_g1, -g2)
  t_g1 <- dplyr::mutate(t_g1, Scaled = range_scale(Observed, num_points)) # range scale data
  return(t_g1)
}
#' Plots the scaled and observed g1(t)) against the correlation time, highlighting the point where g1(t) = 0.5
#'
#' @param t_g1 A tibble consisting of correlation time, calculated g1(t) and scaled g1(t)
#' @export
#' @importFrom tidyr gather
#' @importFrom stats approxfun
#' @importFrom ggplot2 ggplot aes geom_point scale_x_log10 labs geom_hline geom_vline
plot_g1 <- function(t_g1) {
  pred_spl <- g1_spline(t_g1)
  t_g1_data <- tidyr::gather(t_g1, key = g1, Value, -time)
  t_g1_plot <- ggplot2::ggplot(t_g1_data, ggplot2::aes(time, Value, color = g1)) +
    ggplot2::geom_point() +
    ggplot2::scale_x_log10() +
    ggplot2::labs(x = "Correlation time (s)", y = "g1(t)") +
    ggplot2::geom_hline(yintercept = 0.5, linetype = "dashed", color = "blue") +
    ggplot2::geom_vline(xintercept = stats::approxfun(
      x = pred_spl,
      y = t_g1$time
    )(0.5), linetype = "dashed", color = "blue")
  print(t_g1_plot)
}
