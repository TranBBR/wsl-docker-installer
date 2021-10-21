# wsl-docker-installer

This script install a Linux disribution with a Docker server on Windows.

## How to install
- Change current directory to place where you want to install linux image.
- Run _docker-install.ps1_ as Administrator.
- Get IP at the end of the script execution.

Now you can run _debian-docker_ from shortcut on desktop and run docker commands. To access to container from your computer, use provided IP.

## Remove it
- Change current directory to ths install directory
- Run _docker-uninstall.ps1_ as Administrator.

__Note:__ It will keep WSL2 activated.

## Detailled steps of the installer:
- activate WSL2 on Windows
- download a Debian image for Windows (latest)
- deploy it
- update debian image from repositories
- install docker
- test docker with hello container
