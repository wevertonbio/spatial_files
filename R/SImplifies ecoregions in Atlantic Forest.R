####Simplify Ecoregions in Atlantic Forest####
#Remove :
#Southern Atlantic Brazilian mangroves and Southern Cone Mesopotamian savanna and
#Atlantic Coast restingas

library(terra)
library(sf)
library(pbapply)
library(mapview)

#Import ecoregions
eco <- st_read("../spatial_files/Data/Ecoregions_Atlantic_Forest.gpkg")[2]
plot(eco)
eco$ECO_NAME
#Ecoregions to remove
torem <- c("Southern Atlantic Brazilian mangroves",
           "Southern Cone Mesopotamian savanna",
           "Chiquitano dry forests",
           "Atlantic Coast restingas")

#Remove geometries
eco2 <- subset(eco, !(eco$ECO_NAME %in% torem))
plot(eco2)

#Split geometries
mangroove <- st_cast(eco[eco$ECO_NAME %in% torem,],
                               to = "POLYGON")
plot(mangroove)
mangroove$ECO_NAME %>% unique()               

#Get touches
mt <- st_touches(mangroove, eco2)
#Rename
new_names <- pblapply(seq_along(mt), function(i) {
  mt_i <- mt[[i]][1]
  n_i <- eco2$ECO_NAME[mt_i]
  return(n_i)
})
new_names
mangroove$ECO_NAME <- new_names

#Merge data
new_eco <- terra::union(vect(eco2), vect(mangroove)) %>% 
  aggregate(by = "ECO_NAME")
new_eco
#Remove NA
new_eco <- subset(new_eco, !is.na(new_eco$ECO_NAME) & new_eco$ECO_NAME != "NA")
#Crop to atlantic forest
new_eco <- terra::crop(new_eco, af)
plot(new_eco)
mapview(new_eco, zcol = "ECO_NAME")
mapview(eco, zcol = "ECO_NAME")
#Save
writeVector(new_eco, 
            "../spatial_files/Data/Ecoregions_Atlantic_Forest_simplified.gpkg",
            overwrite = TRUE)
