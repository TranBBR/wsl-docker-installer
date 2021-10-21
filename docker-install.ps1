##########################
# WSL Docker installation
##########################
#Requires -RunAsAdministrator

Write-Output "> Activate WSL2"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
wsl --set-default-version 2

if (!(Test-Path ".\debian.zip"))
{
    Write-Output "> Download Windows Debian"
    Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile debian.zip -UseBasicParsing
}

Write-Output "> Extract Debian"
Expand-Archive .\debian.zip .\debian
if (Test-Path ".\debian-docker")
{
    Remove-Item -Recurse .\debian-docker
}
Expand-Archive .\debian\DistroLauncher-Appx_*_x64.appx .\debian-docker
Remove-Item -Recurse .\debian

Write-Output "> Create shortcut on desktop"
$Shell = New-Object -ComObject Wscript.Shell
$Shortcut = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\docker.lnk")
# Cible du raccourci
$Shortcut.TargetPath = "$pwd\debian-docker\debian.exe"
$Shortcut.Save()

Write-Output "> Set up debian"
.\debian-docker\debian.exe install --root
Write-Output "> Install dependencies on debian"
.\debian-docker\debian.exe run apt-get update
.\debian-docker\debian.exe run apt-get install gpg dpkg apt-transport-https ca-certificates curl gnupg lsb-release --yes
Write-Output "> Install Docker on debian"
.\debian-docker\debian.exe run "curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
.\debian-docker\debian.exe run "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
.\debian-docker\debian.exe run apt-get update
.\debian-docker\debian.exe run "export RUNLEVEL=1; apt-get install docker-ce docker-ce-cli containerd.io --yes"
Write-Output "> Activate Docker service"
.\debian-docker\debian.exe run touch /etc/fstab
.\debian-docker\debian.exe run update-alternatives --set iptables /usr/sbin/iptables-legacy
.\debian-docker\debian.exe run service docker start
Write-Output "> Test Docker installation"
.\debian-docker\debian.exe run docker run hello-world
$ips=wsl hostname -I
$ip = ($ips).split(" ")[0]
Write-Output "=> Docker is now available on $ip <="
