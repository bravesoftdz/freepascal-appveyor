
cd src

rem c:\FPC\3.0.0\bin\i386-Win32\fpc adderapp.lpr

appveyor AddMessage "fpc addercheck"
del *.exe *.o *.ppu
c:\FPC\3.0.0\bin\i386-Win32\fpc ^
 -FuFPTest ^
 addercheck.lpr
addercheck
call :addtest "fpc" "addcheck"

appveyor AddMessage "fpc adderapp"
del *.exe *.o *.ppu
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc ^
 -B ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win ^
 -Fuc:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\inc ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\win32 ^
 -Ic:\Ultibo\Core\fpc\3.1.1\source\rtl\i386 ^
 adderapp.lpr

appveyor AddMessage "ultibo addercheck"
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
 addercheck.lpr
addercheck
call :addtest "ultibo" "addercheck"

appveyor AddMessage "ultibo adderapp"
del *.exe *.o *.ppu
C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc ^
 -B ^
 -Tultibo ^
 -Parm ^
 -CpARMV7A ^
 -WpRPI3B ^
 @C:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\RPI3.CFG ^
 -O2 ^
 adderapp.lpr

cd ..

mkdir output
copy src\kernel7.img output
copy bootfiles\*.* output
cd output
7z a ..\kernel7.img.zip kernel7.img
7z a ..\diskimage.zip *.*
cd ..

exit /b %ERRORLEVEL%

:addtest
if %ERRORLEVEL% equ 0 (set CHECKMESSAGE="Passed") else (set CHECKMESSAGE="Failed")
appveyor AddTest -Name %2% -Framework FPTest -FileName %2% -Outcome %CHECKMESSAGE%
exit /b 0