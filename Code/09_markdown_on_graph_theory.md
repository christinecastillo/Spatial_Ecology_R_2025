# 🕸️ Introduction to Graph Theory in Ecology

Graph theory is a powerful tool for representing and analyzing ecological relationships such as food webs, predator–prey interactions, landscape connectivity, or species movement.
In a graph, nodes represent biological entities (species, habitats, populations), and edges represent relationships between them, such as energy flow, competition, or predation.

En este ejemplo construiremos una **red trófica simple** utilizando el paquete `igraph` de R. Nuestro grafo estará compuesto por cinco especies y sus relaciones de depredación, permitiendo visualizar cómo fluye la energía dentro del sistema.
---

# 🧬 Código en R: Red Trófica con `igraph`

```r
# Code for graph theory in ecology

# install.packages("igraph") # run once
library(igraph)

# Species in the food web
species <- c("Algae", "Zooplankton", "Small Fish", "Large Fish", "Bird")

# Predator–prey relationships
predator <- c("Zooplankton", "Small Fish", "Large Fish", "Bird", "Bird")
prey <- c("Algae", "Zooplankton", "Small Fish", "Small Fish", "Large Fish")
# Example: Birds eat Small and Large Fish

# Combine interactions into a data frame
interactions <- data.frame(predator, prey)
interactions

# Create directed graph
g <- graph_from_data_frame(interactions, vertices = species, directed = TRUE)
plot(g)

# Fix seed for reproducibility
set.seed(42)
g <- graph_from_data_frame(interactions, vertices = species, directed = TRUE)
plot(g)
