library(raster)
library(rts)
library(rgdal)
library(gdalUtils)
library(akima)
library(lubridate)
library(MODIS)

setwd("/home/salute/modis")

# MODISoptions(localArcPath= "/home/salute/modis",outDirPath="/home/salute/modis")



#getHdf(product="MOD11A2",collection="005",begin="2013321",end="2016041",tileH=18,tileV=4)

today=format(Sys.Date(),"%Y%j")
last_interval=format(Sys.Date()-16,"%Y%j")

getHdf(product="MOD11A2",collection="005",begin=as.character(last_interval),end=as.character(today),tileH=c(18,19),tileV=c(4,5))
last_dir=list.dirs("MODIS/MOD11A2.005")[length(list.dirs("MODIS/MOD11A2.005"))]
list_files=list.files(last_dir,full.names = T)

# Mosaic for Italy

mosaicHDF(list_files,paste0(getwd(),"/","MOD11A2",strsplit(last_dir,"/")[[1]][3],".hdf"),MRTpath='/home/salute/MRT/bin')




