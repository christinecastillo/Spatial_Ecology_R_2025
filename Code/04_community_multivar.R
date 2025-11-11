#Code for performing multivariate analysis of species x plot data in communities

install.packages("vegan")
library(vegan)

data(dune)

# Dataset
head(dune)
summary(dune)

# Analysis
multivar <- decorana(dune)
multivar

# Axis length
dca1l <- 3.7004
dca2l <- 3.1166
dca3l = 1.30055
dca4l = 1.47888

# get the percentage of the range detected (explain variability) by each axis
total = dca1l + dca2l + dca3l + dca4l
total = sum(c(dca1l, dca2l, dca3l, dca4l))

# Proportions

percdca1 = dca1l*100/total
percdca2 = dca2l*100/total
percdca3 = dca3l*100/total
percdca4 = dca4l*100/total

# Whole amount of variability (%)
percdca1 + percdca2
[1] 71.03683
# The first two axes explain 715 of variability

multipca <- pca(dune)
multipca

plot(multivar)
plot(multipca)
