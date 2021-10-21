##########################
# WSL Docker installation
##########################
#Requires -RunAsAdministrator

if (Test-Path ".\debian.zip")
{
    Remove-Item .\debian.zip
}
if (Test-Path ".\debian")
{
    Remove-Item .\debian
}

wsl -t Debian
wsl --unregister Debian

if (Test-Path ".\debian-docker")
{
    Remove-Item .\debian-docker
}
if (Test-Path ".\debian-docker")
{
    Remove-Item .\debian-docker
}
if (Test-Path($env:USERPROFILE + "\Desktop\docker.lnk"))
{
    Remove-Item($env:USERPROFILE + "\Desktop\docker.lnk")
}

