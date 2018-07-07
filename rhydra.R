#' Runs hydra model
#'
#' Function to run the hydra model for a single time step (dt).
#'
#' 2018-07-06 First version to do simple I/O
#'
#' @param dem A matrix with elevation values in each cell (m)
#' @examples
#' wca2d_1t(dem, ppt, wse, 1, 60, 0)
dyn.load("./src/rhydra.so")
dem_check <- function(dem) {

  simcf = .Fortran("rhydra",
                   m = as.integer(gridx), n = as.integer(gridy),
                   dem = as.double(dem))
  return(simcf)

}

