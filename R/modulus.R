#' This function is used internally for calculating modulus, converting temperature in Celsius to absolute (Kelvin)
#'
#' @param temp A numnber
#' @return A number
#' @examples
#' celsius_to_kelvin(20)
celsius_to_kelvin <- function(temp) {
    return(temp + 273.15)
}
#' This function is used internally for calculating the viscoelastic modulus.
#' @param x A vector
#' @param y A vector (same length as x)
#' @return A vector
#' @examples
#' calc_slope(time, msd)
calc_slope <- function(x, y) {
    ## x and y must be of same length
    slope <- NULL
    slope[1] <- NA
    for (i in 2:(length(x) - 1)) {
        j <- seq(i - 1, i + 1, 1)
        slope <- cbind(slope, lm(log(y[j]) ~ log(x[j]))$coef[2])
    }
    slope[i + 1] <- NA
    return(slope)
}
#' This function is used to calculate the viscoelastic modulus.
#' @param temp A number (temperature, in Celsius)
#' @param radius A number
#' @param msd A vector
#' @param slope A vector
#' @return A vector
#' @examples
#' visco_mod(temp, radius, msd, slope)
visco_mod <- function(temp, radius, msd, slope) {
    s <- na.omit(slope)
    kBoltzmann <- 1.38064852/1e+23
    lo <- 2
    high <- length(msd) - 1
    return((kBoltzmann * celsius_to_kelvin(temp))/(pi * radius * msd[(lo:high)] * (gamma(1 + s))))
}
#' This function is used to calculate the frequency as inverse of time
#' @param t A vector
#' @return A vector
#' @examples
#' calc_freq(time)
calc_freq <- function(t) {
    # t[1] and t[length] are removed
    lo <- 2
    high <- length(t) - 1
    return(1/(t[(lo:high)]))
}
#' This function is used to calculate the storage modulus
#' @param G A vector (viscoelastic modulus)
#' @param slope A vector
#' @return A vector
#' @examples
#' Storage <- calc_Gprime(G, slope)
calc_Gprime <- function(G, slope) {
    s <- na.omit(slope)
    return(G * cos(pi * s/2))
}
#' This function is used to calculate the loss modulus
#' @param G A vector (viscoelastic modulus)
#' @param slope A vector
#' @return A vector
#' @examples
#' Loss <- calc_GDprime(G, slope)
calc_GDprime <- function(G, slope) {
    s <- na.omit(slope)
    return(G * sin(pi * s/2))
}
#' This function produces a tibble consisting of frequency, the storage and loss modulus
#' @param d A tibble consisting of correlation time and related mean square displacement
#' @param temp (optional) temperature in Celsius, default = 20
#' @param radius (optional) particle radius size, default = 5e-7
#' @return A tibble consisting of frequency with related storage and loss modulii
#' @examples
#' e <- calc_modulus(d, 20, 5e-7)
#' @importFrom tibble tibble
#' @export
calc_modulus <- function(d, temp = NULL, radius = NULL) {
  temp <- ifelse(is.null(temp), 20, temp)
  radius <- ifelse(is.null(radius), 5e-7, radius)
  slope <- with(d, calc_slope(time, msd))
  G <- with(d, visco_mod(temp, radius, msd, slope))  #radius <- 5e-7, radius = a & temperature = 20 deg C
  # g <- tibble(freq = with(d, calcFreq(time)), `G'` = calcGprime( G, slope ), `G''` = calcGDprime( G, slope ))
  g <- tibble::tibble(freq = with(d, calc_freq(time)), `Storage (G')` = calc_Gprime(G, slope), `Loss (G'')` = calc_GDprime(G,        slope))
  return(g)
}
#' Plots storage and loss modulus against the measured frequency
#' @param mod_t A tibble consisting of frequency and the related storage and loss modulusA
#' @examples
#' plot_modulus(mod_t)
#' @export
#' @importFrom tidyr gather
#' @importFrom ggplot2 ggplot aes geom_point scale_x_log10 scale_y_log10 labs
plot_modulus <- function(mod_t) {
  mod_t <- tidyr::gather(mod_t, key = Modulus, val, -freq)
  mod_p <- ggplot2::ggplot(mod_t, ggplot2::aes(freq, val, color = Modulus)) + 
      ggplot2::geom_point() + 
      ggplot2::scale_x_log10(limits = c(1, 10000)) + 
      ggplot2::scale_y_log10(limits = c(1, 300)) + 
      ggplot2::labs(x = "Frequency", y = "Modulus")
  suppressWarnings(print(mod_p))
}
