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

# Occurrences
rana$Occurrence

# Selection of presences
pres <- rana[rana$Occurrence==1]
plot(pres)

# Exercise: select all absences
abse <- rana[rana$Occurrence==0]
# or
abse <- rana[rana$Occurrence!=1]
plot(abse)

abse$Occurrence
pres$Occurrence

# Exercise: plot the presences with a color together with the absences with another color
plot(abse, col="#66CD00") # #66CD00
points(pres, col="#FF1493") #deeppink #FF1493

# I cannot use the plot because it will overwrite

# Exercise: do the same in a multiframe with the two sets: pres on top 
par(mfrow=c(2,1)) 
plot(pres)
plot(abse)

#xlim and ylim to change the x and y to be the same on the graphs
