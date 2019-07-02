################################################################################
#Exercise 1.1
################################################################################
install.packages("sp")
install.packages("rgdal")
install.packages("raster")
install.packages("rgeos")
library(sp)
library(rgdal)
library(raster)
library(rgeos)

#Or a bit cleaner
pkgs <- c("sp","rgdal","raster","rgeos")
for(i in pkgs){
  if(!i %in% installed.packages()[,1]){
    install.packages(i)
  }
}
x<-lapply(pkgs, library, character.only = TRUE)

################################################################################
#Exercise 2.1
################################################################################
us_states <- readOGR("data","tl_2015_us_state")
summary(us_states)

################################################################################
#Exercise 2.2
################################################################################
dc_nlcd <- raster("data/dc_nlcd.tif")
plot(dc_nlcd)

################################################################################
#Exercise 3.1
################################################################################
dc_bnd <- subset(us_states, NAME == "District of Columbia")
dc_bnd_prj <- spTransform(dc_bnd,CRS(proj4string(dc_nlcd)))

################################################################################
#Exercise 3.2
################################################################################
dc_bnd_1000 <- gBuffer(dc_bnd_prj, width = 1000)
dc_outer_1000 <- gDifference(dc_bnd_1000, dc_bnd_prj)
gArea(dc_bnd_prj)
gArea(dc_bnd_1000)
gArea(dc_outer_1000)
gArea(dc_bnd_1000) - gArea(dc_bnd_prj)

################################################################################
#Exercise 3.3
################################################################################
dc_in_nlcd <- crop(dc_nlcd,dc_bnd_prj)
dc_in_nlcd <- mask(dc_in_nlcd,dc_bnd_prj)
dc_outer_nlcd <- mask(crop(dc_nlcd,dc_outer_1000),dc_outer_1000)
in_lulc <- round(table(values(dc_in_nlcd))/length(values(dc_in_nlcd)),3)*100
in_lulc
out_lulc <- round(table(values(dc_outer_nlcd))/length(values(dc_outer_nlcd)),3)*100
out_lulc
#Legend: http://www.mrlc.gov/nlcd01_leg.php

################################################################################
#Exercise 4.1
################################################################################
plot(dc_nlcd)
plot(dc_bnd_prj,add=T)
map <- qmap(dc_nlcd,dc_bnd_prj,colors=c(NA,"black"))
zi(map)
zo(map)
i(map)
i(map,2)
p(map)
f(map)

################################################################################
#Exercise 4.2
################################################################################
map <- leaflet()
map <- addTiles(map)
map <- addPolygons(map,data=dc_bnd)
map
map <- addRasterImage(map, dc_in_nlcd)
map
