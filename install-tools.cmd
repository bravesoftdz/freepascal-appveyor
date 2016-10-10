
if exist c:\FPC goto installed_fpc
curl -fsSL -o fpc-installer.exe "http://downloads.sourceforge.net/project/freepascal/Win32/3.0.0/fpc-3.0.0.i386-win32.exe?r=&ts=1475862864&use_mirror=pilotfiber"
fpc-installer.exe /verysilent
dir c:\FPC
:installed_fpc

echo on

if exist c:\Ultibo goto installed_ultibo
curl -fsSL -o ultibo-installer.exe https://github.com/ultibohub/Core/releases/download/1.2.009/Ultibo-Core-1.2.009-Cucumber.exe
ultibo-installer /verysilent
dir c:\Ultibo
curl -fsSL -o ultibo-rtl-update.zip https://github.com/ultibohub/Core/archive/master.zip
dir *.zip
dir c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
rd /s /q c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
7z e -oc:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo ultibo-rtl-update.zip
dir c:\Ultibo\Core\fpc\3.1.1\source\rtl\ultibo
:installed_ultibo

echo off

if exist bootfiles goto installed_bootfiles
mkdir bootfiles
cd bootfiles
curl -fsSL -o bootcode.bin https://github.com/raspberrypi/firmware/raw/master/boot/bootcode.bin
curl -fsSL -o fixup.dat    https://github.com/raspberrypi/firmware/raw/master/boot/fixup.dat
curl -fsSL -o start.elf    https://github.com/raspberrypi/firmware/raw/master/boot/start.elf
cd ..
:installed_bootfiles