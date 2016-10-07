curl -fsSL -o fpc-installer.exe "http://downloads.sourceforge.net/project/freepascal/Win32/3.0.0/fpc-3.0.0.i386-win32.exe?r=&ts=1475862864&use_mirror=pilotfiber"
fpc-installer.exe /verysilent
echo installed fpc
dir c:
dir d:
d:\FPC\3.0.0\bin\386-Win32\fpc appveyortest.pas