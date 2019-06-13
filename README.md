
#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with sec_bolt](#setup)
    * [What sec_bolt affects](#what-sec_bolt-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sec_bolt](#beginning-with-sec_bolt)
3. [Usage - Configuration options and additional functionality](#usage)

## Description

This modules is designed to set up a Puppet SE demo environment for the compliance/security bolt workshop as delivered in Portland on 5/31/2019.  A presentation exists in Google Drive that includes talking points and setup for the environment. 

It also contains the tasks, scripts, and puppet files used for "audit remediation" as part of the workshop.

## Setup

### What sec_bolt affects **OPTIONAL**

This module provides plans, tasks, and manifests to :

Setup :
  1. Add 3 users to all linux and windows "client" machines (does not touch the puppet master and gitlab servers), by applying the lnx_add_user.pp and win_add_user.pp puppet files.
    * capncrunch
    * dproberts
    * bob
    All 3 users are local Administrators on Windows, and part of the admin/wheel group on linux.
    Home directories and passwords are created
  2. Installs/enables the FTP service on Windows
  3. Installs/enables vsftpd on linux
  3. Installs the telnet client on linux & windows

Manifests:
  win_add_user.pp
    Creates above listed user accounts on windows.

  lnx_add_user.pp
    Creates above listed user accounts on linux.

  del_user.pp
    Deletes the "capncrunch" account on both OSes.

  lnx_usermod.pp
    1. Removes the capncrunch account
    2. Removes "bob" from the adm & wheel groups
    3. sets the login shell for dproberts user to /bin/false (disables login)

Tasks: 
  win_ftp_install
   Installs the windows Web-Ftp-Server feature.  The native bolt package task seems to depend on Chocolatey, which doesn't appear to like features (or I can't figure it out), so using this to install, enable, and start the windows feature.

  win_telnet_install
    Installs the windows telnet-client feature.  See above for Chocolately issues.

  win_usermod
    disables the dproberts user account

Plans:
  win_setup
    Sets everything up on Windows nodes

  lnx_setup
    Sets everything up on Linux nodes

  remediate_windows
   1. Runs the "disable_win_user" task
   2. Runs the "remove_win_admin" task
   3. Runs a command to remove the "Telnet-Client" windows feature

  remediate_linux
   1. Runs the "disable_nix_user" task
   2. Runs the "remove_admin_nix" task
   3. Runs a command to remove the telnet package

### Setup Requirements **OPTIONAL**

Have SE Demo environment created with Puppet Agents installed

### Beginning with sec_bolt_setup

You should have a SE demo environment deployed, and an inventory.yaml file updated to properly access all windows and linux client/student machines.  The instructions assume that you have added Windows Admin passwords to your inventory file (bad idea for production/customers, really convenient for demos), and have host keys set up so you can log in without entering a password.

## Usage

Simple execute the plan on all client/student systems, similar to below :

  > bolt plan run sec_bolt::lnx_setup -n lnxstudents 
  > bolt plan run sec_bolt::win_setup -n winstudents 

During the workshop, the students do the following :
  > bolt command run “puppet resource user” -n winX,nixX
  > bolt apply modules/sec_bolt/manifests/deluser.pp -n winX,nixX

  > bolt command run "Stop-Service -name FTPSVC" -n winX
  > bolt command run “Set-Service FTPSVC -StartupType Disable” -n winX 
  > bolt command run “sudo systemctl stop vsftpd” -n nixX
  > bolt command run “sudo systemctl disable vsftpd” -n nixX

  > bolt plan run sec_bolt::remediate_windows -n winX
  > bolt plan run sec_bolt::remediate_linux -n nixX

