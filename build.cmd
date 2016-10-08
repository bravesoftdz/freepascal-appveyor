set PATH=c:\FPC\3.0.0\bin\i386-Win32;%PATH%
fpc appveyortest.lpr
fpc -FuFPTest appveyortestcheck.lpr
appveyortestcheck

C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc -B -Tultibo -Parm -CpARMV7A -WpRPI3B @C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\RPI3.CFG -O2 appveyortest.lpr
