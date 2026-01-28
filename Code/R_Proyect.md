---

Title: "Multitemporal Analysis of Vegetation Change in Madre de Dios, Perú (2019 - 2024) Using Sentinel-2 Imagery"
Author: "Christine Nicole Castillo Rivera"
Matricola: 0001217398
Date: "28-01-2026"
---

# Multitemporal Analysis of Vegetation Change in Madre de Dios, Perú (2019 - 2024) Using Sentinel-2 Imagery

---

## Introduction

The Peruvian Amazon is a biodiversity hotspot that has experienced significant changes in vegetation cover over recent years. Monitoring these changes with satellite imagery provides a powerful way to quantify and visualize spatial variations in vegetation, supporting research in spatial ecology and conservation. For this study, images from July were selected because the dry season reduces cloud cover, allowing clearer observation of vegetation patterns. Vegetation dynamics were analyzed using the Difference Vegetation Index (DVI) and the Normalized Difference Vegetation Index (NDVI), complemented by unsupervised land cover classification. This approach enables a detailed assessment of vegetation health and land cover changes over time, offering valuable insights into ecosystem dynamics in the Madre de Dios region.
  
------ 

## Materials - 

**Software**: 
- Google Earth Engine (GEE) for downloading satellite images.
- R (with terra, imageRy, viridis, and ggplot2 packages) for image analysis and visualization. - 

**Data**: 
- Sentinel-2 images for July 2019, 2022, and 2024. 

**Hardware**: 

- Computer capable of handling high-resolution raster images.
---

## Methods

### 1. Defining the Area of Interest (AOI) in GEE

The study was conducted in the Madre de Dios region, Peru. The area of interest (AOI) was manually defined as a polygon in Google Earth Engine (GEE), covering approximately 3,060.96 km².

```
var aoi = ee.Geometry.Polygon(
    [[[-69.63174398820153, -12.467175749655912],
      [-69.63174398820153, -12.889883444720278],
      [-69.03144415299646, -12.889883444720278],
      [-69.03144415299646, -12.467175749655912]]], null, false);
```

The polygon area was calculated:

```
var area_km2 = aoi.area(1).divide(1e6);
print('Polygon area (km²):', area_km2);
```

Result: 3060.96 km².

### 2. Downloading and Selecting Sentinel-2 Images

### Sentinel 2 image for July 2019:
 
```
var collection = ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
                   .filterBounds(aoi)
                   .filterDate('2019-07-01','2019-07-31')
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
                   .median()
                   .clip(aoi);

print(collection);

Map.addLayer(collection,{bands:['B4','B3','B2'], min: 0, max: 3000})
```

The bands B4 (red), B3 (green), B2 (blue), and B8 (near-infrared) were selected.

- B2, B3, B4 allow visualization of the landscape in true color.
- B8 (NIR) is highly sensitive to vegetation and is used to calculate indices. 

Exported to Google Drive for further analysis in R:

```
Export.image.toDrive({
  image:collection.select(['B4','B3','B2','B8']),
  description: 'sentinel2_median_07_2019',
  region: aoi,
  scale: 10,
  maxPixels: 1e13
});
```

This process was repeated for 2022 and 2024.

### Sentinel 2 image for July 2022:

```
var collection = ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
                   .filterBounds(aoi)
                   .filterDate('2022-07-01','2022-07-31')
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
                   .median()
                   .clip(aoi);
                  
print(collection);

Map.addLayer(collection,{bands:['B4','B3','B2'], min: 0, max: 3000})
```

```
Export.image.toDrive({
  image:collection.select(['B4','B3','B2']),
  description: 'sentinel2_median_07_2022',
  region: aoi,
  scale: 10  ,
  maxPixels: 1e13
});
```

### Sentinel 2 image for July 2024:

```
var collection = ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
                   .filterBounds(aoi)
                   .filterDate('2024-07-01','2024-07-31')
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
                   .median()
                   .clip(aoi);
                  
print(collection);

Map.addLayer(collection,{bands:['B4','B3','B2'], min: 0, max: 3000})
```

```
Export.image.toDrive({
  image:collection.select(['B4','B3','B2']),
  description: 'sentinel2_median_07_2024',
  region: aoi,
  scale: 10  ,
  maxPixels: 1e13
});
```

### 3. Analysis in R

## Setting up the workspace

Define the working directory where downloaded images are stored:

```
setwd("C://Users/chris/Desktop/Proyect R/")
```

## Load required packages

```
library(terra)      # Raster data handling
library(imageRy)    # Image manipulation utilities
library(viridis)    # Color-blind–friendly color palettes
library(ggplot2)    # Data visualization
library(gridExtra)  # To arrange plots side by side
```

## Import Sentinel-2 raster images

```
RGB_NIR_2019 <- rast("sentinel2_median_07_2019.tif")
RGB_NIR_2022 <- rast("sentinel2_median_07_2022.tif")
RGB_NIR_2024 <- rast("sentinel2_median_07_2024.tif")
```

## Visualize and name the bands B2, B3, B4, B8

```
names(RGB_NIR_2019) <- c("B2 (Blue)", "B3 (Green)", "B4 (Red)", "B8 (NIR)")
names(RGB_NIR_2022) <- c("B2 (Blue)", "B3 (Green)", "B4 (Red)", "B8 (NIR)")
names(RGB_NIR_2024) <- c("B2 (Blue)", "B3 (Green)", "B4 (Red)", "B8 (NIR)")
```

```
plot(RGB_NIR_2019, col = plasma(100))
plot(RGB_NIR_2022, col = plasma(100))
plot(RGB_NIR_2024, col = plasma(100))
```

### Sentinel 2 bands of July 2019

![Rplot_2019](https://github.com/user-attachments/assets/a8730b44-b074-43e5-914d-9c580f55cfec)

*Figure 1: Sentinel-2 raster bands for July 2019 over the Madre de Dios region, Perú. The image shows four bands: B2 (blue), B3 (green), B4 (red), and B8 (near-infrared, NIR). The color scale used is the "plasma" palette from the R package viridis.*

### Sentinel 2 bands of July 2022

![Rplot_2022](https://github.com/user-attachments/assets/c715e23e-cd81-43e4-9e63-97f5002373d2)

*Figure 2: Sentinel-2 raster bands for July 2022 over the Madre de Dios region, Perú. The image shows four bands: B2 (blue), B3 (green), B4 (red), and B8 (near-infrared, NIR). The color scale used is the "plasma" palette from the R package viridis.*

### Sentinel 2 bands of July 2024

![Rplot_2024](https://github.com/user-attachments/assets/a11c296c-d6be-42db-9cf1-db77a1c6fc32)

*Figure 3: Sentinel-2 raster bands for July 2024 over the Madre de Dios region, Perú. The image shows four bands: B2 (blue), B3 (green), B4 (red), and B8 (near-infrared, NIR). The color scale used is the "plasma" palette from the R package viridis.*

### Visualization of RGB Images for 2019, 2022, and 2024

To arrange plots in a single row:

```
par(mfrow = c(1, 3)) 
```

```
plotRGB(RGB_NIR_2019, r = 1, g = 2, b = 3, stretch = "lin", main = "RGB 2019") 
plotRGB(RGB_NIR_2022, r = 1, g = 2, b = 3, stretch = "lin", main = "RGB 2022") 
plotRGB(RGB_NIR_2024, r = 1, g = 2, b = 3, stretch = "lin", main = "RGB 2024")
 ```

![RGBplot_2019_2022_2024](https://github.com/user-attachments/assets/5764d982-7081-4e04-811b-bb442f924a4c)

*Figure 4: RGB composites of the Madre de Dios region for July 2019, 2022, and 2024, showing changes in vegetation cover over the dry season.*

### Visualization of Vegetation Using NIR (Near-Infrared) Band

The NIR (Near-Infrared) band is crucial because healthy vegetation strongly reflects NIR light, whereas stressed or sparse vegetation reflects less.  
By substituting the Blue band with NIR in the RGB composite, vegetation areas become more visually distinct (blue), while non-vegetation areas appear in contrasting colors (yellow), allowing a clear assessment of vegetation cover and health.

Arrange plots side by side

```
par(mfrow = c(1, 2))
```

Plot RGB with NIR replacing the Blue band for 2019 and 2024

```
plotRGB(RGB_NIR_2019, r = 1, g = 2, b = 4, stretch = "lin", main = "Madre de Dios, 2019")
plotRGB(RGB_NIR_2024, r = 1, g = 2, b = 4, stretch = "lin", main = "Madre de Dios, 2024")
```

![Rplot_NIR](https://github.com/user-attachments/assets/e94fbec6-a0a6-450e-bd1d-2d7d8cde7488)

*Figure 5: Comparison of RGB composites with NIR (Band B8) replacing Blue for the Madre de Dios region in July 2019 and 2024. Vegetation appears blue, highlighting areas of healthy growth, while non-vegetation areas appear yellow, allowing a clear visualization of vegetation changes over time.*

# DVI Analysis (Difference Vegetation Index)

The Difference Vegetation Index (DVI) is a vegetation index used to highlight the presence and density of vegetation in an area.  
It is calculated as the difference between the near-infrared (NIR) band and the red band:

$` DVI = NIR - Red `$   

Where:  
- **NIR**: near-infrared band (e.g., B8 in Sentinel-2)  
- **Red**: red band (e.g., B4 in Sentinel-2)  

---

- **High positive values** indicate areas with healthy, dense vegetation.  
- **Values near zero** indicate bare soil, rocks, or areas with little vegetation.  
- **Negative values** are rare and may indicate water or data anomalies.  

---

## DVI Calculation

The DVI was computed separately for the Sentinel-2 images of July 2019 and July 2024 using Band B8 (NIR) and Band B4 (Red):

```
dvi_2019 <- RGB_NIR_2019[["B8 (NIR)"]] - RGB_NIR_2019[["B4 (Red)"]]
dvi_2024 <- RGB_NIR_2024[["B8 (NIR)"]] - RGB_NIR_2024[["B4 (Red)"]]
```

## DVI Difference Between Years (ΔDVI)

To assess vegetation change over time, the difference between the two DVI layers was calculated:

```
ddvi <- dvi_2019 - dvi_2024
```

```
par(mfrow = c(1, 3))

plot(dvi_2019, main = "DVI 2019", col = inferno(100))
plot(dvi_2024, main = "DVI 2024", col = inferno(100))
plot(ddvi, main = "ΔDVI (2019 - 2024)", col = inferno(100))
```

![Rplot_DVI](https://github.com/user-attachments/assets/e39f23c2-9e9f-4604-9e2a-4e50dd4d7926)

*Figure 6: Difference Vegetation Index (DVI) maps for July 2019 and July 2024, and their difference (ΔDVI = DVI(2019) − DVI(2024)) for the Madre de Dios region, Peru.*

**The DVI maps show a general decrease in vegetation vigor from 2019 to 2024. Higher DVI values, associated with healthy vegetation, are more widespread in 2019, while the ΔDVI map (2019 − 2024) highlights predominantly positive values, indicating a reduction in vegetation cover or health over time in several areas of the study region.**

# Normalized Difference Vegetation Index (NDVI) Analysis

To further assess vegetation health and compare changes between 2019 and 2024, the Normalized Difference Vegetation Index (NDVI) was calculated. NDVI is a widely used vegetation index that normalizes the Difference Vegetation Index (DVI) by the sum of the Near-Infrared (NIR) and Red bands, allowing for better comparison across time and space.

The NDVI is defined as:

$` NDVI = \frac{(NIR - Red)}{(NIR + Red)} `$ 

## NDVI Calculation

Using the previously computed DVI layers, NDVI was calculated for each year:

```
ndvi2019 <- (RGB_NIR_2019[["B8 (NIR)"]] - RGB_NIR_2019[["B4 (Red)"]]) / (RGB_NIR_2019[["B8 (NIR)"]] + RGB_NIR_2019[["B4 (Red)"]])
ndvi2024 <- (RGB_NIR_2024[["B8 (NIR)"]] - RGB_NIR_2024[["B4 (Red)"]]) / (RGB_NIR_2024[["B8 (NIR)"]] + RGB_NIR_2024[["B4 (Red)"]])
```

## NDVI Difference Between Years (ΔNDVI)

To evaluate temporal changes in vegetation health, the difference between NDVI values was computed:

```
dndvi <- ndvi2019 - ndvi2024
```

## Visualization of NDVI and ΔNDVI

```
par(mfrow = c(1, 3))

plot(ndvi2019, main = "NDVI 2019", col = magma(100))
plot(ndvi2024, main = "NDVI 2024", col = magma(100))
plot(dndvi, main = "ΔNDVI (2019 − 2024)", col = inferno(100))
```

![Rplot_NDVInew](https://github.com/user-attachments/assets/e74a2337-7451-4a74-a35b-2b1afdfd3ccc)

*Figure 7: Normalized Difference Vegetation Index (NDVI) maps for July 2019 and July 2024, and their difference (ΔNDVI = NDVI(2019) − NDVI(2024)) for the Madre de Dios region, Peru.*​

### Multitemporal Analysis

The multitemporal analysis allowed the comparison of Sentinel-2 satellite data from 2019 and 2024, focusing on the Near-Infrared (NIR) band and the Normalized Difference Vegetation Index (NDVI). This approach was used to highlight significant changes in vegetation condition over the analyzed period.

By comparing these indicators across time, it is possible to identify areas affected by vegetation loss, degradation, or stress.

## NIR and NDVI Differences

The temporal differences were calculated by subtracting the 2019 values from the 2024 values:

```
nir_diff  <- RGB_NIR_2024[["B8 (NIR)"]] - RGB_NIR_2019[["B8 (NIR)"]]
ndvi_diff <- ndvi2024 - ndvi2019
```

## Visualization of Multitemporal Changes

```
par(mfrow = c(1, 2))

plot(nir_diff, col = viridis(100), main = "NIR Difference (2024 − 2019)")
plot(ndvi_diff, col = viridis(100), main = "NDVI Difference (2024 − 2019)")
```

![Rplotnirdifference_new](https://github.com/user-attachments/assets/e90c1e96-f615-4498-a8de-6786c71b686f)

*Figure 8: Multitemporal comparison of Near-Infrared (NIR) reflectance and Normalized Difference Vegetation Index (NDVI) for the Madre de Dios region, Peru, between July 2019 and July 2024.*

### Multitemporal Land Cover Classification (2019–2024)

An unsupervised classification was applied to Sentinel-2 imagery from July 2019 and July 2024 to assess land cover changes in the Madre de Dios region, Peru. The analysis focused on the Red (B4) and Near-Infrared (B8) bands, which are effective for distinguishing vegetation, water bodies, and bare soil.

Four land cover classes were identified based on spectral response and visual interpretation:

- Water
- Bare soil
- Moderate vegetation
- Healthy vegetation

 ## Selection of spectral bands:
 
```
s2_2019 <- RGB_NIR_2019[[c("B4 (Red)", "B8 (NIR)")]]
s2_2024 <- RGB_NIR_2024[[c("B4 (Red)", "B8 (NIR)")]]
```

## Unsupervised Classification

```
class_2019 <- im.classify(s2_2019, num_clusters = 4)
class_2024 <- im.classify(s2_2024, num_clusters = 4)

par(mfrow = c(1, 2))
plot(class_2019, col = viridis(4), main = "Land Cover Classification 2019")
plot(class_2024, col = viridis(4), main = "Land Cover Classification 2024")
```

![Rplot_newland](https://github.com/user-attachments/assets/19225701-f676-4fa2-a1cb-6023f49ac440)

*Figure 9: Unsupervised land cover classification for the Madre de Dios region, Peru, using Sentinel-2 imagery from July 2019 and July 2024. Four classes were identified (water, bare soil, moderate vegetation, and healthy vegetation) based on Red and Near-Infrared spectral responses.*

## Land Cover Proportions

```
freq_2019 <- freq(class_2019)
freq_2024 <- freq(class_2024)

perc_2019 <- freq_2019$count * 100 / ncell(class_2019)
perc_2024 <- freq_2024$count * 100 / ncell(class_2024)
```

## Summary Table

```
class_names <- c("Water", "Bare soil", "Moderate vegetation", "Healthy vegetation")

tab_lc <- data.frame(
  Class = class_names,
  Perc_2019 = perc_2019,
  Perc_2024 = perc_2024
)

tab_lc
```

| Class               | Perc_2019  | Perc_2024  |
|--------------------|------------|------------|
| Water               | 32.868449  | 42.956808  |
| Bare soil           | 43.563945  | 17.009621  |
| Moderate vegetation | 18.732856  | 34.252317  |
| Healthy vegetation  | 4.813505   | 5.760008   |


## Visualization of Changes

```
p2019 <- ggplot(tab_lc, aes(x = Class, y = Perc_2019, fill = Class)) +
  geom_bar(stat = "identity") +
  ylim(0, 100) +
  scale_fill_viridis_d() +
  theme_minimal() +
  labs(title = "Land Cover Distribution – 2019", y = "Percentage (%)")

p2024 <- ggplot(tab_lc, aes(x = Class, y = Perc_2024, fill = Class)) +
  geom_bar(stat = "identity") +
  ylim(0, 100) +
  scale_fill_viridis_d() +
  theme_minimal() +
  labs(title = "Land Cover Distribution – 2024", y = "Percentage (%)")

grid.arrange(p2019, p2024, ncol = 2)
```

![Rplot_LandCovercompar](https://github.com/user-attachments/assets/970f2a82-a987-460a-bf9b-7e6ff5a1fc6b)

*Figure 9: Multitemporal comparison of unsupervised land cover classification for the Madre de Dios region, Peru, using Sentinel-2 imagery from July 2019 and July 2024. Four classes were identified (water, bare soil, moderate vegetation, and healthy vegetation) based on Red and Near-Infrared spectral responses.*

### Conclusions

- The analysis shows a clear reduction in healthy vegetation between 2019 and 2024 in several areas of the study region. Both DVI and NDVI maps indicate a decline in vegetation vigor, confirming patterns observed in RGB and NIR visualizations.
- Using the Near-Infrared band allowed for a clear distinction between vegetation and non-vegetation areas, making it easier to assess vegetation health. Satellite imagery proved to be a reliable and efficient tool for monitoring spatial and temporal changes in vegetation cover.
- Unsupervised classification revealed shifts in land cover over time, with reductions in healthy vegetation and increases in bare soil and moderate vegetation areas. These results highlight potential impacts of land use, environmental stress, or human activities in the region.
- Water-covered areas increased, likely due to permanent rivers, lakes, or mining ponds. Bare soil decreased as some areas were replaced by vegetation or water. Moderate vegetation expanded, reflecting regrowth of secondary forests, while dense, healthy vegetation slightly increased but remains limited. 

### References

- R Core Team. (2024). R: A language and environment for statistical computing. R Foundation for Statistical Computing. https://www.R-project.org/
- Google Earth Engine Team. (2023). Google Earth Engine: Planetary-scale geospatial analysis for everyone. https://earthengine.google.com/
