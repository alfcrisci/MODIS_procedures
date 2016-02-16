library(raster)
library(rts)
library(rgdal)
library(gdalUtils)
library(akima)
library(lubridate)
library(MODIS)

setwd("/home/salute/modis")

source("aux_func_modis.r")

#MODISoptions(localArcPath= "home/salute/modis",outDirPath="/home/salute/modis")


################################################################################
# Products : NDVI(1) EVI(2)  QA(3)  Pixel Reliability (12)

modis_class_data="MOD13Q1"

# getHdf(product=modis_class_data,begin="2014129",end="2014135",tileH=18,tileV=4)


list_files=list.files(path="./MODIS/MOD13Q1.005","hdf",full.names = T, recursive = T)
list_files=gsub("^./","/home/salute/modis/",list_files)

# Data extraction

files=gsub("^.*/","",list_files)
strdatex=as.Date(as.vector(sapply(files,FUN=function(x) as.Date(paste(c(substr(x,10,13),substr(x,14,18)),collapse="-"),"%Y-%j"))))
files_tif=gsub(".hdf",".tif",files)


# reprojection images

res_MODIS_MOD13Q1_2015=list()

setwd("/home/salute/modis/modis_current/veg")

for ( i in 1:length(list_files)) {

 reprojectHDF(list_files[i],files_tif[i],
                    LR=c(30.0,23.094010768),UL=c(50.0,0.0),
                    proj_type="GEO",
                    datum="WGS84",
                    resample_type="NEAREST_NEIGHBOR",
                    bands_subset="1 1 1 0 0 0 0 0 0 0 0 1")  
  
}

file.remove("resample.log")
file.remove("tmp.prm")
  
setwd("/home/salute/modis")
################################################################################

