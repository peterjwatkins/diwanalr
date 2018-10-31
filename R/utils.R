# get rid of notes that result from using dplyr
# to manipulate data
utils::globalVariables(
  c(
    "freq",
    "g1",
    "g2",
    "msd",
    "Modulus",
    "Observed",
    "Scaled",
    "time",
    "Value",
    "val"
  )
)