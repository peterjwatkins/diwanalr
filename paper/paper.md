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

DWS has been applied the analysis to food systems. Some examples include understanding the dynamics of emulsion  systems (e.g. fat in water) such as mayonnaise [@Kim2019] along with the gellation of food products [@Alexander2006].

DWS also has practical applications in the pharmaceutical and cosmetic industries as well [@Reufer2014].

In some instances, the analysis of data resulting from DWS measurements can be tedious depending on, for example, the use of spreadsheets for numerical analysis, or multiple software packages [@Niederquell2017]. The **diwanalr** package has been developed as an alternative approach, allowing data analysis to be readily performed using a single software package, within R. The package has a set of functions which can be readily and seamlessly deployed after the measurement of data. Further functionality can be added to the package as required.

The package utilises four R packages (*dplyr*, *ggplot2*,  *tibble* and *tidyr*) in its implementation.

# Background

At present, the package can be deployed to determine the viscoelastic, storage and loss moduli of a system using data, consisting of time and related values from the temporal autocorrelation function, *g*~2~($t$). The latter is related to the intensity autocorrelation function, *g*~1~($t$), by the Seigert equation, where *g*~2~($t$) = 1 + $|$*g*~1~($t$)$|$$^2$ [@Seigert]. The *g*~1~($t$) values are used to determine the mean square displacement (MSD)  for transmission geometry by solving the relationship [@Weitz]:
 
\begin{center}
*g*$_{1}$($t$)$\approx\frac{(\frac{L}{l*}+\frac{4}{3})\sqrt{\frac{6t}{\tau}}}{(1+\frac{8t}{3\tau})sinh[\frac{L}{l*}\sqrt{\frac{6t}{\tau}}]+\frac{4}{3}\sqrt{\frac{6t}{\tau}}cosh[\frac{L}{l*}\sqrt{\frac{6t}{\tau}}]}$
\end{center}

which are then used to calculate the *viscoelastic* modulus, and related *storage* and *loss* moduli for the system under study.

# Acknowledgement
The author wishes to acknowledge, and credit, W. N. (Bill) Venables for optimising the code for the MSD determination.

# References
