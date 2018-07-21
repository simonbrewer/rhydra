## Test case (runs Chad example)

require(raster)
dyn.load("./src/rhydra_testing.so")

load("./data/chadExample_hydra_clim.RData")
rhydra <- function(nyrs, startyear, converg = 1, laket = 0, spin = 1,
                   normal = 1, leap = 1, irrig = 1,
                   outnewi, outnewj, basin, dem, rivdir, mflac,
                   prcpi, evapi, runin, drainin,
                   gridxf, gridyf) {
  
  simcf = .Fortran("rhydra",
                   nyrs = as.integer(nyrs),
                   startyear = as.integer(startyear), 
                   converg = as.integer(converg), 
                   laket = as.integer(laket), 
                   spin = as.integer(spin),
                   normal = as.integer(normal), 
                   leap = as.integer(leap), 
                   irrig = as.integer(irrig),
                   outnewi = as.double(outnewi), outnewj = as.double(outnewj),
                   basin = as.double(basin), dem = as.double(dem),
                   outdir = as.double(rivdir), sillh = as.double(mflac),
                   prcpi = as.double(prec), evapi = as.double(evap),
                   runin = as.double(runoff), drainin = as.double(drain),
                   outelv = double(gridxf*gridyf), lakem = double(gridxf*gridyf),
                   lakevolm = double(12*(nyrs+spin)), lakevola = double(nyrs+spin))
  return(simcf)

}

## Parameters
nyrs = 1 # of years to run the model after January 1937
startyear = 1 # year to start run (from January 1937) 
converg = 1 # 0 if set convergence helper, 1 if not
laket = 0 # 0 if predict lakes, 1 if parameterized with Cogley obs, 2 if with previously simulated
spin = 0  # number of spin-up years to run before reading transient data
normal = 1 # 0 if use normalization, 1 if not
leap = 2 # of years to the first leap year
irrig = 1 # 0 if use irrigation, function 1 if not

## Grid dimensions
gridxf = 216
gridyf = 216

hydro.out = rhydra(nyrs, startyear, converg, laket, spin,
                   normal, leap, irrig,
                   outnewi, outnewj, basin, dem, rivdir, mflac,
                   prcpi, evapi, runin, drainin,
                   gridxf, gridyf)

# save(hydro.out, file=paste0("rhydra_out_",spin,".Rdata"))
