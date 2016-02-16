mosaicHDF=function(hdfNames,filename,MRTpath='/home/salute/MRT/bin',bands_subset,delete=FALSE) {
            if (missing(MRTpath)) stop("MRTpath argument should be specified...")
            if (length(hdfNames) < 2) stop("mosaic cannot be called for ONE image!")
            if (missing(bands_subset))  bands_subset <- ''
            if (missing(delete)) delete <- FALSE
            
            mosaicname = file(paste(MRTpath, "/TmpMosaic.prm", sep=""), open="wt")
            write(paste(hdfNames[1], sep=""), mosaicname)
            for (j in 2:length(hdfNames)) write(paste(getwd(),"/",hdfNames[j], sep=""),mosaicname,append=T)
            close(mosaicname)
            # generate mosaic:
            
            if (bands_subset != '') {
              e <- system(paste(MRTpath, '/mrtmosaic -i ', MRTpath, '/TmpMosaic.prm -s "',bands_subset,'" -o ',getwd(), '/',filename, sep=""))
              if (e != 0) warning ("Mosaic failed! 'bands_subset' may has incorrect structure!")
            } else {
              e <- system(paste(MRTpath, '/mrtmosaic -i ', MRTpath, '/TmpMosaic.prm -o ',getwd(), '/',filename, sep=""))
              if (e != 0) warning ("Mosaic failed!")
            }
            if (delete & e == 0) for (ModisName in hdfNames) unlink(paste(getwd(), '/', ModisName, sep=""))
            if (e == 0) return (TRUE)
            else return (FALSE)
          }


reprojectHDF=function(hdfName,filename,MRTpath="/home/salute/MRT/bin",UL="",LR="",resample_type='NEAREST_NEIGHBOR',proj_type='UTM',
                   bands_subset='',proj_params='0 0 0 0 0 0 0 0 0 0 0 0',datum='WGS84',utm_zone=NA,pixel_size=1000) {
            
            fname = file('tmp.prm', open="wt")
            write(paste('INPUT_FILENAME = ', hdfName, sep=""), fname) 
            if (bands_subset != '') {
              write(paste('SPECTRAL_SUBSET = ( ',bands_subset,' )',sep=''),fname,append=TRUE)
            }
            if (UL[1] != '' & LR[1] != '') {
              write('SPATIAL_SUBSET_TYPE = INPUT_LAT_LONG ', fname, append=TRUE)
              write(paste('SPATIAL_SUBSET_UL_CORNER = ( ', as.character(UL[1]),' ',as.character(UL[2]),' )',sep=''), fname, append=TRUE)
              write(paste('SPATIAL_SUBSET_LR_CORNER = ( ', as.character(LR[1]),' ',as.character(LR[2]),' )',sep=''), fname, append=TRUE)
            }
            write(paste('OUTPUT_FILENAME = ', filename, sep=""), fname, append=TRUE)
            write(paste('RESAMPLING_TYPE = ',resample_type,sep=''), fname, append=TRUE)
            write(paste('OUTPUT_PROJECTION_TYPE = ',proj_type,sep=''), fname, append=TRUE)
            write(paste('OUTPUT_PROJECTION_PARAMETERS = ( ',proj_params,' )',sep=''), fname, append=TRUE)
            write(paste('DATUM = ',datum,sep=''), fname, append=TRUE)
            if (proj_type == 'UTM') write(paste('UTM_ZONE = ',utm_zone,sep=''), fname, append=TRUE)
            #write(paste('OUTPUT_PIXEL_SIZE = ',as.character(pixel_size),sep=''), fname, append=TRUE)
            close(fname)
            e <- system(paste(MRTpath, '/resample -p ',getwd(),'/','tmp.prm', sep=''))
            if (e == 0) return (TRUE)
            else return(FALSE)
          }

infofromMODIShdf=function(x,datechar=""){
  require(gdalUtils)  
  names=gsub("  SUBDATASET_(\\d*)_NAME=","",grep("_NAME",gdalinfo(x),value=T))
  outnames=list()
  for ( i in 1:length(names)) {
     str=strsplit(as.character(names[i]),":")
     outnames[[i]]=gsub(" ",".",paste0(as.character(str[[1]][5]),"_",datechar,".tif"))
  }
  outnames=unlist(outnames)
  res=list()
  res$outnames=outnames
  res$names=names
  return(res)
}
