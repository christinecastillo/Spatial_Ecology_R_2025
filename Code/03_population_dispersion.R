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
pres$Occurrence

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

###################################

# Covariates
elev <- system.file("external/elevation.asc", package="sdm") 
elev
[1] "C:/Users/chris/AppData/Local/R/win-library/4.4/sdm/external/elevation.asc"

elevmap <- rast(elev)
cl <- colorRampPalette(c("green", "pink", "blue" ))(100)
plot(elevmap)

# install.packages("viridis")
library(viridis)

plot(elevmap, col=magma(100))
plot(elevmap, col=mako(100))               #Extension asc estamos usando esos archivos del folder

temp <- system.file("external/temperature.asc", package="sdm")
temp
[1] "C:/Users/chris/AppData/Local/R/win-library/4.4/sdm/external/temperature.asc"
tempmap <- rast(temp)
plot(tempmap, col=mako(1000))
points(rana)

#Exercise: plot elev and temp maps one beside the other with the points

par(mfrow=c(2,1))
plot(elevmap, col=magma(100))
points(rana)
plot(tempmap, col=mako(1000))
points(rana)

prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap, col=magma(100))
points(rana)

vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(prec)
plot(vegemap, col=mako(100))
points(rana)

#Exercise: plot all the maps e¿with 2 rows and 2 column

par(mfrow=c(2,2))
plot(elevmap, col=magma(100))
plot(tempmap, col=viridis(1000))
plot(precmap, col=magma(100))
plot(vegemap, col=rocket(100))

cova <- c(elevmap, tempmap, precmap, vegemap)
plot(cova)

plot(cova$temperature, col=mako(100))  #Para solo sacar uno y cambiar uno por uno

# Assuming 'rana' is your SpatVector with points and attributes
# Extract coordinates using the geom() function
coordinates <- geom(rana)

# Convert the coordinates to a data frame
coordinates_df <- as.data.frame(coordinates)

# Extract the 'Occurrence' attribute from the SpatVector
occurrence_df <- as.data.frame(rana$Occurrence)

# Combine the coordinates and the occurrence data into one data frame
final_df <- cbind(coordinates_df, occurrence_df)

# Export the final data frame to a CSV file
write.csv(final_df, "coordinates_with_occurrence.csv", row.names = FALSE)

# View the first few rows of the final table (optional)
head(final_df)

# Add the attribute column (e.g., Occurrence) to the data frame
coordinates_df$Occurrence <- rana$Occurrence

# Export the data frame to a CSV file
write.csv(coordinates_df, "coordinates_with_occurrence.csv", row.names = FALSE)


