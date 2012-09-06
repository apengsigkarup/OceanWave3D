SUBROUTINE Initialize
USE GlobalVariables
IMPLICIT NONE
INTEGER i

! Computed constants
pi = ACOS(-one)
deg2rad=pi/180._long
!
! Predefined I/O file handles
! INPUT
FILEIP(1) = 7  ! Input file handle number
! Get first command line argument
CALL GETARG(1,filenameINPUT)
IF (LEN_TRIM(filenameINPUT)==0) THEN
   ! Set standard input filename when not specified by user
   filenameINPUT = 'OceanWave3D.inp'
ENDIF
print*,filenameINPUT
OPEN (UNIT=FILEIP(1),FILE=filenameINPUT,STATUS='UNKNOWN',ERR=100,IOSTAT=STAT)
!
! Fileip(3) is associated with the initial condition file (if it exists) "OceanWave3D.init". 
Fileip(3)=3 
! Fileip(4) is associated with the bathymetry file (if it exists) in fname_bottom.  
Fileip(4)=4
!
! OUTPUT
!FILEOP(1) = 8  ! LOG.txt
FILEOP(1:14) = (/ (i,i=8,21) /)
! First file is the log file.
OPEN (UNIT=FILEOP(1),FILE='LOG.txt',STATUS='UNKNOWN')
! Files 2:11 are possible kinematics output files opened and written to in 
! subroutine StoreKinematicData, called by the main line.
fnt(1:10) = (/ '01','02','03','04','05','06','07','08','09','10' /)
! File 12 is 'local.smoothing' opened and written to by subroutine 'LocalSmoothing2D' 
!         called by the main line.  
! File 13 is the file 'relax.chk' written to by subroutine PreprocessRelaxationZones 
!         called by the main line.
! File 14 is the file 'roller.dat' written to by subroutine detect_breaking
!         called by the main line.


RETURN

! ERROR HANDLING
100 PRINT *,'Error: Problem with specified input file.'; STOP

END SUBROUTINE Initialize
