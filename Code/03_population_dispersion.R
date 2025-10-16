# Code for analysing species dispersion

# install.packages("terra")
library(terra)

# install.packages("sdm") # species distibution modelling
library(sdm)

file <- system.file("external/species.shp", package="sdm")
# [1] "C:/Users/chris/AppData/Local/R/win-library/4.4/sdm/external/species.shp"

rana <- vect(file)
rana

plot(rana)

rana$Occurrence
