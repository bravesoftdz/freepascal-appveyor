
if exist c:\FPC goto installed_fpc
appveyor message "installing fpc"
curl -fsSL -o fpc-installer.exe "http://downloads.sourceforge.net/project/freepascal/Win32/3.0.0/fpc-3.0.0.i386-win32.exe?r=&ts=1475862864&use_mirror=pilotfiber"
fpc-installer.exe /verysilent
rd /s /q c:\FPC\3.0.0\demo
rd /s /q c:\FPC\3.0.0\doc
rd /s /q c:\FPC\3.0.0\examples
dir c:\FPC
:installed_fpc

if exist c:\Ultibo goto installed_ultibo
appveyor message "installing ultibo"
curl -fsSL -o ultibo-installer.exe https://github.com/ultibohub/Core/releases/download/1.2.009/Ultibo-Core-1.2.009-Cucumber.exe
ultibo-installer /verysilent
goto :removed
rd /s /q c:\Ultibo\Core\docs
rd /s /q c:\Ultibo\Core\examples
rd /s /q c:\Ultibo\Core\firmware
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\fcl-db
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\googleapi
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\gtk1
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\gtk2
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\oracle
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\winceunits
rem rd /s /q c:\Ultibo\Core\fpc\3.1.1\packages\winunits-jedi
rd /s /q c:\Ultibo\Core\languages
rd /s /q c:\Ultibo\Core\lazarus.exe
rd /s /q c:\Ultibo\Core\lazbuild.exe
:removed
dir c:\Ultibo
curl -fsSL -o ultibo-rtl-update.zip https://github.com/ultibohub/Core/archive/master.zip
dir *.zip
7z x -oultibo-rtl-update ultibo-rtl-update.zip
dir ultibo-rtl-update\Core-master\source\rtl\ultibo
dir c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
rd /s /q c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
xcopy /s /i ultibo-rtl-update\Core-master\source\rtl\ultibo c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
dir c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
:installed_ultibo

if exist bootfiles goto installed_bootfiles
appveyor message "installing bootfiles"
mkdir bootfiles
cd bootfiles
curl -fsSL -o bootcode.bin https://github.com/raspberrypi/firmware/raw/master/boot/bootcode.bin
curl -fsSL -o fixup.dat    https://github.com/raspberrypi/firmware/raw/master/boot/fixup.dat
curl -fsSL -o start.elf    https://github.com/raspberrypi/firmware/raw/master/boot/start.elf
cd ..
:installed_bootfiles