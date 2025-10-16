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

# Plotting together the density map and the elevation
el <- bei.extra[[1]]

# one object is dmap and the other is el
# how to plot the dmap beside el?
par(mfrow=c(1,2)) # we will solve this anti-human stuff soon!
plot(dmap)
plot(el)

# plot the dmap ontop of the el map
par(mfrow=c(2,1)) 
plot(dmap)
plot(el)

# if you want to close graphical devices this is your friend:
dev.off()

cl <- colorRampPalette(c("green", "red", "blue"))
plot(dmap, col=cl)

cl <- colorRampPalette(c("green", "red", "blue"))(100)
plot(dmap, col=cl)

# R colors are here:
# https://r-charts.com/colors/

cln <- colorRampPalette(c("chartreuse1", "brown2", "cyan", "lightblue"))
plot(dmap, col=cln)

# plot the dmap with two different color ramps one on top of the other
dev.off()

par(mfrow=c(2,1)) 
plot(dmap, col=cl)
plot(dmap, col=cln)
