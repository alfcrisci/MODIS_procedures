
library(downloader)

## time index of MODIS products

for (i in 306:358) {

download.file(url=paste0("http://opendap.cr.usgs.gov/opendap/hyrax/MOD13Q1.005/h18v04.ncml.dods?_250m_16_days_NDVI[",i,"][0:1:4799][0:1:4799]"),destfile=paste0("ndvi_h18v04_",i,".dods"))

download.file(url=paste0("http://opendap.cr.usgs.gov/opendap/hyrax/MOD13Q1.005/h18v04.ncml.dods?_250m_16_days_EVI[",i,"][0:1:4799][0:1:4799]"),destfile=paste0("evi_h18v04_",i,".dods"))

download.file(url=paste0("http://opendap.cr.usgs.gov/opendap/hyrax/MOD13Q1.005/h18v04.ncml.dods?_250m_16_days_VI_Quality[",i,"][0:1:4799][0:1:4799]"),destfile=paste0("quality_h18v04_",i,".dods"))

}
