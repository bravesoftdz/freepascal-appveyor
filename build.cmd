set PATH=c:\FPC\3.0.0\bin\i386-Win32;%PATH%
fpc appveyortest.lpr
fpc -FuFPTest appveyortestcheck.lpr
appveyortestcheck