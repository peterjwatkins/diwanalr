---
title: 'diwanalr: An R data analysis package for diffusing-wave spectroscopy'
tags:
  - R
  - DWS
  - Diffusing-wave spectroscopy
  - data analysis
authors:
 - name: Peter J Watkins
   orcid: 0000-0002-1290-3843
   affiliation: "1"
affiliations:
 - name: Commonwealth Scientific and Industrial Research Organisation
   index: 1
date: 17 July 2018
bibliography: paper.bib
---

# Summary

The **diwanalr** (**di**ffusing-**wa**ve spectroscopy (DWS) **anal**ysis using **R**) package contains a number of functions suitable for analysing DWS data.
DWS is an optical technique derived from dynamic light scattering which studies the dynamics of scattered light [@Weitz].
If carefully calibrated, DWS allows the quantitative measurement of microscopic motion in a soft material, which can be used with micro-rheology to determine the rheological properties of such a complex medium.
Research capability exists which allows the application of DWS to food systems.
In some instances, the analysis of data resulting from such capability can be tedious (e.g. using spreadsheets).
This package is intended to allow users of such capability to perform analysis of DWS data in a more straightforward manner.

The package utilises four R packages (*dplyr*, *ggplot2*,  *tibble* and *tidyr*) in its implementation.

# Background

At present, the package can be deployed to determine the viscoelastic, storage and loss moduli of a system using data, consisting of time and related values from the temporal autocorrelation function, *g*~2~($t$). The latter is related to the intensity autocorrelation function, *g*~1~($t$), by the Seigert equation, where *g*~2~($t$) = 1 + $|$*g*~1~($t$)$|$$^2$ [@Seigert]. The *g*~1~($t$) values are used to determine the mean square displacement (MSD)  for transmission geometry by solving the relationship  *g*$_{1}$($t$)$\approx\frac{(\frac{L}{l*}+\frac{4}{3})\sqrt{\frac{6t}{\tau}}}{(1+\frac{8t}{3\tau})sinh[\frac{L}{l*}\sqrt{\frac{6t}{\tau}}]+\frac{4}{3}\sqrt{\frac{6t}{\tau}}cosh[\frac{L}{l*}\sqrt{\frac{6t}{\tau}}]}$[@Weitz], which are then used to calculate the *viscoelastic* modulus, and related *storage* and *loss* moduli for the system under study.

# Acknowledgement
The author wishes to acknowledge, and credit, W. N. (Bill) Venables for optimising the code for the MSD determination.

# References