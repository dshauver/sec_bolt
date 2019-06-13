# Puppet Task Name: win_ftp_install

#Install ftp server
Install-WindowsFeature Web-Ftp-Server -IncludeAllSubFeature -IncludeManagementTools -Verbose

#Set service to start at boot
Set-Service FTPSVC -StartupType Automatic

#Start service
Start-Service -Name FTPSVC