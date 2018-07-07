!-------------------------------------------------------------------------------
! RHYDRA: Version of hydra hydrological model to be called from R
!
! Coe, M.T. 2000: Modeling terrestrial hydrological systems at the continental 
! scale: Testing the accuracy of an atmospheric GCM, 
! Journal of Climate, 13, 686-704.
!
! Ver. 0.1 Simple template to read in a DEM
!-------------------------------------------------------------------------------

      subroutine rhydra( m, n, dgper, scale, dem)
      !-------------------------------------------------------------------------
      ! Input variables
      integer m,n ! Grid sizes
      double precision dem( m, n ) ! Elevation values (m)
      !-------------------------------------------------------------------------
      ! Main loop through grid cells

      do 10 i=2,(m-1)

      do 20 j=2,(n-1)
      write(*,*) dem(i,j)

20    continue
10    continue
      end
