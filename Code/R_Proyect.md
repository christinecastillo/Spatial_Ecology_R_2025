---

Title: "Spatial Distribution"
Author: "Christine Nicole Castillo Rivera"
Matricola: 0001217398
Date: "28-01-2026"
---

# Spatial Ecology Project in R

## Vegetation Change in Madre de Dios, Peru

This project aims to analyze vegetation changes in a region of the Peruvian Amazon (Madre de Dios) using Sentinel-2 satellite images downloaded from Google Earth Engine (GEE) and processed later in R.

---

## Introduction

The Peruvian Amazon is a biodiversity hotspot that has experienced significant changes in vegetation cover over recent years. Analyzing these changes with satellite imagery allows quantifying and visualizing spatial variations in vegetation, contributing to research in spatial ecology and conservation.

---

## Materials

- **Software**:  
  - Google Earth Engine (GEE) for downloading and preprocessing satellite images.  
  - R (with `terra`, `imageRy`, `viridis`, and `ggplot2` packages) for image analysis and visualization.  

- **Data**:  
  - Sentinel-2 images for July 2019, 2022, and 2024.  
  - Area of Interest (AOI) defined manually as a polygon in GEE.

- **Hardware**:  
  - Computer capable of handling high-resolution raster images.
    
---

## Methods

### 1. Defining the Area of Interest (AOI) in GEE

A polygon was manually created in Google Earth Engine to delimit the study area:

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

For each study year (2019, 2022, 2024), the following steps were performed:

- Images were filtered by date and cloud percentage (<20%).
- The median of the filtered collection was calculated.
- Images were clipped to the AOI polygon.
- Images were exported to Google Drive for later download.

### Sentinel 2 image for July 2019:

To analyze vegetation during the dry season in Peru, we selected images from **July**, when cloud cover is generally lower and vegetation patterns are more clearly visible. 
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

We selected the bands B4 (red), B3 (green), B2 (blue), and B8 (near-infrared).

- B2, B3, B4 allow visualization of the landscape in true color.
- B8 (NIR) is highly sensitive to vegetation and is used to calculate indices like NDVI, which highlight plant health and biomass.

Finally, the image was exported to Google Drive for further analysis in R:

```
Export.image.toDrive({
  image:collection.select(['B4','B3','B2','B8']),
  description: 'sentinel2_median_07_2019',
  region: aoi,
  scale: 10,
  maxPixels: 1e13
});
```

This process was repeated for 2022 and 2024, generating three median images per year.

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

### 2. Analysis in R

Setting up the workspace

Define the working directory where downloaded images are stored:

```
setwd("C://Users/chris/Desktop/Proyect R/")
```

Load required packages

```
library(terra)      # Raster data handling
library(imageRy)    # Image manipulation utilities
library(viridis)    # Color-blind–friendly color palettes
library(ggplot2)    # Data visualization
```

Import Sentinel-2 raster images

```
RGB_NIR_2019 <- rast("sentinel2_median_07_2019.tif")
RGB_NIR_2022 <- rast("sentinel2_median_07_2022.tif")
RGB_NIR_2024 <- rast("sentinel2_median_07_2024.tif")
```

Visualize and name the bands B2, B3, B4, B8

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

*Figure 2: Sentinel-2 raster bands for July 2024 over the Madre de Dios region, Perú. The image shows four bands: B2 (blue), B3 (green), B4 (red), and B8 (near-infrared, NIR). The color scale used is the "plasma" palette from the R package viridis.*

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

*Figure 3: RGB composites of the Madre de Dios region for July 2019, 2022, and 2024, showing changes in vegetation cover over the dry season.*

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

*Figure: Comparison of RGB composites with NIR (Band B8) replacing Blue for the Madre de Dios region in July 2019 and 2024. Vegetation appears blue, highlighting areas of healthy growth, while non-vegetation areas appear yellow, allowing a clear visualization of vegetation changes over time.*

**A noticeable decrease in blue intensity over the years indicates a reduction in healthy vegetation cover, suggesting potential vegetation loss or stress in certain areas.**

# DVI Analysis (Difference Vegetation Index)

## Definition
The **Difference Vegetation Index (DVI)** is a vegetation index used to highlight the presence and density of vegetation in an area.  
It is calculated as the difference between the near-infrared (NIR) band and the red band:

$` DVI = NIR - Red `$   

Where:  
- **NIR**: near-infrared band (e.g., B8 in Sentinel-2)  
- **Red**: red band (e.g., B4 in Sentinel-2)  

---

## Interpretation
- **High positive values** indicate areas with healthy, dense vegetation.  
- **Values near zero** indicate bare soil, rocks, or areas with little vegetation.  
- **Negative values** are rare and may indicate water or data anomalies.  

---

## Calculation in R

```r
library(raster)

# Assuming the raster has NIR and Red bands
nir <- campoimp19[[4]]  # B8
red <- campoimp19[[3]]  # B4

# Calculate DVI
dvi <- nir - red

# Plot DVI with coordinates and color scale
plot(dvi,
     main = "Campo Imperatore - DVI 2019",
     xlab = "Longitude",
     ylab = "Latitude",
     col = viridis::viridis(100))



