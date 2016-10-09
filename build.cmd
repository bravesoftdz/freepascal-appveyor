
cd src

rem c:\FPC\3.0.0\bin\i386-Win32\fpc appveyortest.lpr

del *.exe *.o *.ppu
c:\FPC\3.0.0\bin\i386-Win32\fpc ^
 -FuFPTest ^
 appveyortestcheck.lpr
appveyortestcheck

del *.exe *.o *.ppu
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc ^
 -B ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\i386 ^
 appveyortest.lpr

del *.exe *.o *.ppu
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc ^
 -B ^
 -FuFPTest ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\i386 ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\objpas ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\win ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win\wininc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source/rtl/objpas/sysutils ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source/rtl/objpas/classes ^
 -Fuc:\Ultibo\Core\fpc\3.1.1/source/packages/fcl-base/src ^
 -Fuc:\Ultibo\Core\fpc\3.1.1/source/packages/fcl-registry/src ^
 -Fuc:\Ultibo\Core\fpc\3.1.1/source/packages/winunits-base/src ^
 -Fuc:\Ultibo\Core\fpc\3.1.1/source/packages/rtl-objpas/src/inc ^
 appveyortestcheck.lpr
appveyortestcheck

del *.exe *.o *.ppu
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc ^
 -B ^
 -Tultibo ^
 -Parm ^
 -CpARMV7A ^
 -WpRPI3B ^
 @C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\RPI3.CFG ^
 -O2 ^
 appveyortest.lpr

cd ..

mkdir output
copy src\kernel7.img output
copy bootfiles\*.* output
cd output
7z a ..\kernel7.img.zip kernel7.img
7z a ..\diskimage.zip *.*
cd ..
