# This code is related to the possibility to use AI to speed up coding practices

# Example with a for loop, let's take the code from the overlap example

# First: teach the process to chatGPT - example: density plots for two species

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

# Now ask chatGPT to speed up the process

# State something like:
# I would like to build a for loop to make the density plot of all of the species together in a multiframe

library(overlap)

data(kerinci)

# Add circular time column
kerinci$circ <- kerinci$Time * 2 * pi

# Get unique species names
# Get all species
species_list <- unique(kerinci$Sps)
n_species <- length(species_list)

# Set up multiframe (square layout)
rows <- ceiling(sqrt(n_species))
cols <- ceiling(n_species / rows)

# Adjust the number of rows and columns based on the number of species
# Set up a multi-frame plot (e.g., 2 rows, 2 columns)
par(mfrow = c(rows, cols))   # Create multiframe # Change this if you have more species

# Loop through species list and plot density
# Loop to plot each species
for (sp in species_list) {
  sp_data <- kerinci$circ[kerinci$Sps == sp]
  densityPlot(sp_data, main = paste("Density -", sp))
}

# Reset plotting window
par(mfrow = c(1,1))

# Other option

# Get unique species names
species_list <- unique(kerinci$Sps)

# Set up a multi-frame plot (e.g., 2 rows, 2 columns)
# Adjust the number of rows and columns based on the number of species
par(mfrow = c(2, 2))  # Change this if you have more species

# Loop through species list and plot density
for (species in species_list) {
  # Subset data for the current species
  species_data <- kerinci[kerinci$Sps == species, ]
  
  # Create the density plot for the current species
  densityPlot(species_data$circ, 
              main = paste("Density Plot: ", species),
              col = "blue", 
              lwd = 2, 
              xlab = "Circumference Time (radians)", 
              ylab = "Density")
}

