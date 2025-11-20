# This code is analysing the temporal overlap between species

# install.packages("overlap")
library(overlap)            # suntools

data(kerinci)
kerinci

summary(kerinci)

circulartime <- kerinci$Time * 2 * pi
circulartime

kerinci$circ <- kerinci$Time * 2 * pi #Agrega una columna al data set eso lo hago con el $ en vez de crear una totalmente nueva como arriba
head(kerinci)

# tiger data
tiger <- kerinci[kerinci$Sps=="tiger",]
timetiger <- tiger$circ

densityPlot(timetiger)
densityPlot(tiger$circ)

# Exercise: Create a kernel density plot for the species called macaque
macaque <- kerinci[kerinci$Sps=="macaque",]
macaque
timemacaque <- macaque$circ
densityPlot(timemacaque)

overlapPlot(timetiger, timemacaque)
