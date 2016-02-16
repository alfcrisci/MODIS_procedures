library(raster)
library(rts)
library(rgdal)
library(gdalUtils)
library(akima)
library(lubridate)
library(MODIS)

setwd("/home/salute/modis")

# MODISoptions(localArcPath= "/home/salute/modis",outDirPath="/home/salute/modis")

getHdf(product="MOD13Q1",collection="005",begin="2009335",end="2009365",tileH=18,tileV=4)

#lastdate

#getHdf(product="MOD13Q1",collection="005",begin="2016001",end="2016041",tileH=18,tileV=4)

