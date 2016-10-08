
if exist c:\FPC goto installed_fpc
curl -fsSL -o fpc-installer.exe "http://downloads.sourceforge.net/project/freepascal/Win32/3.0.0/fpc-3.0.0.i386-win32.exe?r=&ts=1475862864&use_mirror=pilotfiber"
fpc-installer.exe /verysilent
dir c:\FPC\3.0.0
:installed_fpc

if exist c:\Ulibo goto installed_ultibo
curl -fsSL -o ultibo-installer.exe https://github.com/ultibohub/Core/releases/download/1.2.009/Ultibo-Core-1.2.009-Cucumber.exe
ultibo-installer /verysilent
dir c:\Ultibo
:installed_ultibo


