
rem set PATH=c:\FPC\3.0.0\bin\i386-Win32;%PATH%
rem fpc appveyortest.lpr
rem fpc -FuFPTest appveyortestcheck.lpr
rem appveyortestcheck

C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc appveyortest.lpr
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc appveyortestcheck.lpr
appveyortestcheck

C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc -B -Tultibo -Parm -CpARMV7A -WpRPI3B @C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\RPI3.CFG -O2 appveyortest.lpr
