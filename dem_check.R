require(raster)
dyn.load("./src/rhydra.so")

dem_check <- function(dem) {

  simcf = .Fortran("rhydra",
                   m = as.integer(gridx), n = as.integer(gridy),
                   dem = as.double(dem))
  return(simcf)

}

###############################################################################
## Load DEM data
dem.r = raster("dem1.nc")
dem = as.matrix(dem.r)
## Grid dimensions
gridx = dim(dem)[1]
gridy = dim(dem)[2]

dem_check(dem)