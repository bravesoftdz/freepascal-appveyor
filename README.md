# freepascal-appveyor [![Build status](https://ci.appveyor.com/api/projects/status/97syuiai5ieh68nv?svg=true)](https://ci.appveyor.com/project/markfirmware/freepascal-appveyor)
Build pascal firmware to run on raspberry pi, using the [ultibo](http://ultibo.org) derivative of [freepascal](http://freepascal.org). This repo particularly demonstrates the use of AppVeyor to conduct the build.

## Using the Build Output on a Pi

Download disk images from the most recent build at [AppVeyor Artifacts](https://ci.appveyor.com/project/markfirmware/freepascal-appveyor/build/artifacts). Each image is a compressed zip file. Unzip this file to an empty FAT-formatted SD card. Safely eject and remove the card. Power-down the pi, insert the card, and power-on the pi. In a few seconds the application will be running.

## Road Map

### Automation

#### Deliver build output to private raspberry farm for testing and return results to builder for reporting

#### Deliver build output to public raspberry farm for testing and return results to builder for reporting
