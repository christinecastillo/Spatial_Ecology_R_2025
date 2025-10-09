#Code related to population ecology
# A package is needed for point pattern analysis
#To install the package
install.packages("spatstat")

library(spatstat)

# let's use the bei data:
# data description:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data
plot(bei)

# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)
plot(bei, pch=20, cex=.5)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev)

# with 1 is just elevation 
plot(bei.extra[[1]])
plot(bei.extra[[2]])

elevation <- bei.extra$elev
el <- bei.extra[[1]] 
plot(el)

?density #me da info
# passing from points to a countinuous surface
beidens <- density(bei)

plot(beidens)
points(bei)
