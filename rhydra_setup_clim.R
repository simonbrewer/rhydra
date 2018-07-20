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
## Load climate data
nyrs = 59

## Precip
prec.r = stack("../geomorphNetCDFin/rain.nc")
dem2.r = crop(dem.r, extent(prec.r))
prec.r.m = stackApply(prec.r, rep(seq(1,12), nyrs), fun=mean)
#prec.r.m = resample(prec.r.m, dem2.r, method="ngb")
prec.r.y = stackApply(prec.r.m, rep(1, 12), fun=mean)
prec.r.c = stack(replicate(59,prec.r.m))

## Evap
evap.r = stack("../geomorphNetCDFin/evap.chadf.nc")
evap.r.m = stackApply(evap.r, rep(seq(1,12), nyrs), fun=mean)
#evap.r.m = resample(evap.r.m, dem2.r, method="ngb")
evap.r.y = stackApply(evap.r.m, rep(1, 12), fun=mean)
evap.r.c = stack(replicate(59,evap.r.m))

## Runoff
runoff.r = stack("../geomorphNetCDFin/srunoff.ex4.nc")
runoff.r.m = stackApply(runoff.r, rep(seq(1,12), nyrs), fun=mean)
#runoff.r.m = resample(runoff.r.m, dem2.r, method="ngb")
runoff.r.y = stackApply(runoff.r.m, rep(1, 12), fun=mean)
runoff.r.c = stack(replicate(59,runoff.r.m))

## Runoff
drain.r = stack("../geomorphNetCDFin/drainage.ex4.nc")
drain.r.m = stackApply(drain.r, rep(seq(1,12), nyrs), fun=mean)
#drain.r.m = resample(drain.r.m, dem2.r, method="ngb")
drain.r.y = stackApply(drain.r.m, rep(1, 12), fun=mean)
drain.r.c = stack(replicate(59,drain.r.m))

prec = aperm(as.array(prec.r.c), c(2,1,3))
evap = aperm(as.array(evap.r.c), c(2,1,3))
drain = aperm(as.array(drain.r.c), c(2,1,3))
runoff = aperm(as.array(runoff.r.c), c(2,1,3))

## Grid dimensions
# gridx = dim(dem)[1]
# gridy = dim(dem)[2]

demf.r = crop(dem.r, extent(raster(prec.r,1)))
save(dem,demf.r,basin,outnewi,outnewj,rivdir,mflac,
     prec,evap,drain,runoff, file="chadExample_hydra_clim.RData")
