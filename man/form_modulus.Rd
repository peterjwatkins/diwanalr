% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modulus.R
\name{form_modulus}
\alias{form_modulus}
\title{This function produces a tibble consisting of frequency, the storage and loss modulus}
\usage{
form_modulus(msd_t, temp = NULL, radius = NULL)
}
\arguments{
\item{msd_t}{A tibble consisting of correlation time and related mean square displacement}

\item{temp}{(optional) temperature in Celsius, default = 20}

\item{radius}{(optional) particle radius size, default = 5e-7}
}
\value{
A tibble consisting of frequency with related storage and loss modulii
}
\description{
This function produces a tibble consisting of frequency, the storage and loss modulus
}
