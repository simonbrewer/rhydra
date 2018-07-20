## Test case (runs Chad example)

require(raster)

# Geomorphology data
outnewi.r = raster("../geomorphNetCDFin/outnewi.nc")
outnewj.r = raster("../geomorphNetCDFin/outnewj.nc")
basin.r = raster("../geomorphNetCDFin/basin.nc")
dem.r = raster("../geomorphNetCDFin/tbase.nc")
rivdir.r = raster("../geomorphNetCDFin/rivdir.nc")
mflac.r = raster("../geomorphNetCDFin/mflac.nc")

outnewi = t(as.matrix(outnewi.r))
outnewj = t(as.matrix(outnewj.r))
basin = t(as.matrix(basin.r))
dem = t(as.matrix(dem.r))
rivdir = t(as.matrix(rivdir.r))
mflac = t(as.matrix(mflac.r))

## Commented just to speed things up
# Climate data
prec.r = stack("../geomorphNetCDFin/rain.nc")
evap.r = stack("../geomorphNetCDFin/evap.chadf.nc")
drain.r = stack("../geomorphNetCDFin/drainage.ex4.nc")
runoff.r = stack("../geomorphNetCDFin/srunoff.ex4.nc")

prec = aperm(as.array(prec.r), c(2,1,3))
evap = aperm(as.array(evap.r), c(2,1,3))
drain = aperm(as.array(drain.r), c(2,1,3))
runoff = aperm(as.array(runoff.r), c(2,1,3))

## Grid dimensions
# gridx = dim(dem)[1]
# gridy = dim(dem)[2]

demf.r = crop(dem.r, extent(raster(prec.r,1)))
save(dem,demf.r,basin,outnewi,outnewj,rivdir,mflac,
     prec,evap,drain,runoff, file="chadExample_hydra.RData")
