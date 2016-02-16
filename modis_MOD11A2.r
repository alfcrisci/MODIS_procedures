library(raster)
library(rts)
library(rgdal)
library(gdalUtils)
library(akima)
library(lubridate)
library(MODIS)

setwd("/home/salute/modis")

# MODISoptions(localArcPath= "/home/salute/modis",outDirPath="/home/salute/modis")

getHdf(product="MOD11A2",collection="005",begin="2013321",end="2016041",tileH=18,tileV=4)

