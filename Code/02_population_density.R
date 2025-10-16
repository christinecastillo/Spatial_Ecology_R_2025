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
densitymap <- density(bei)

plot(densitymap)
plot(beidens)
points(bei)

# Plotting together the density map and the elevation
el <- bei.extra[[1]]

# one object is dmap and the other is el
# how to plot the dmap beside el?
par(mfrow=c(1,2)) # we will solve this anti-human stuff soon! # rows are 1, columns are 2 
plot(dmap)
plot(el)

# plot the dmap ontop of the el map
par(mfrow=c(2,1)) 
plot(dmap)
plot(el)

par(mfrow=c(2,1))
plot(densitymap)
plot(el)

# if you want to close graphical devices this is your friend:
dev.off()
null device 
          1 

#Changing the color of our maps
cl <- colorRampPalette(c("black", "red", "yellow"))
plot(densitymap, col=cl)

cl <- colorRampPalette(c("black", "red", "yellow"))(5)
plot(densitymap, col=cl)

cl <- colorRampPalette(c("black", "red", "yellow"))(100)
plot(densitymap, col=cl)

# R colors are here:
# https://r-charts.com/colors/

# Exercise: using the following available colors, remake a coloring palette of your map:
# https://r-charts.com/colors/

cln <- colorRampPalette(c("#CD5B45", "#8B5F65", "#D15FEE", "#36648B"))
plot(densitymap, col=cln)
clm <- colorRampPalette(c("#FF1493", "#7FFFD4", "#D15FEE", "#36648B"))
plot(densitymap, col=clm)
clx <- colorRampPalette(c("chartreuse1", "brown2", "cyan", "lightblue"))
plot(densitymap, col=clx)

# Exercise: plot the dmap with two different color ramps one on top of the other
par(mfrow=c(2,1))
plot(densitymap, col=clm)
plot(el, col=cln)

# Exercise: make a final graph with: the points, the elevation, the dmaps, the dmaps with two different color schemes
par(mfrow=c(2,2))
plot(bei)
plot(el)
plot(densitymap, col=clm)
plot(densitymap, col=clx)

dev.off()
