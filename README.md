
# sec_bolt_setup

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with sec_bolt_setup](#setup)
    * [What sec_bolt_setup affects](#what-sec_bolt_setup-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sec_bolt_setup](#beginning-with-sec_bolt_setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This modules is designed to set up a Puppet SE demo environment for the compliance/security bolt workshop as delivered to Compunet on 5/31/2019.  A presentation exists in Google Drive that includes talking points and setup for the environment. 

It also contains the tasks, scripts, and puppet files used for "audit remediation" as part of the workshop.

## Setup

### What sec_bolt_setup affects **OPTIONAL**

This modules does the following :

create_lnx_audit_findings, create_win_audit_findings plans :
  1. Adds 3 users to all linux and windows "client" machines (does not touch the puppet master and gitlab servers), by applying the lnx_add_user.pp and win_add_user.pp puppet files.
    * capncrunch
    * dproberts
    * bob
    All 3 users are local Administrators on Windows, and part of the admin/wheel group on linux.
    Home directories and passwords are created
  2. Installs/enables the FTP service on Windows
  3. Installs/enables vsftpd on linux
  3. Installs the telnet client on linux & windows

files/win_add_user.pp
  Creates above listed user accounts on windowss

files/lnx_add_user.pp
  Creates above listed user accounts on linux.

win_usermod task
  1. deletes the capncrunch user account
  2. disables the dproberts user account

files/lnx_usermod.pp
  1. Removes the capncrunch account
  2. Removes "bob" from the adm & wheel groups
  3. sets the login shell for dproberts user to /bin/false (disables login)

files/lnx_userdel.pp
  Removes the above listed accounts - used for testing purposes


### Setup Requirements **OPTIONAL**

Have SE Demo environment created with Puppet Agents installed

### Beginning with sec_bolt_setup

You should have a SE demo environment deployed, and an inventory.yaml file updated to properly access all windows and linux client/student machines.  The instructions assume that you have added Windows Admin passwords to your inventory file (bad idea for production/customers, really convenient for demos), and have host keys set up so you can log in without entering a password.

## Usage

Simple execute the plan on all client/student systems, similar to below :

  > bolt plan run "create_lnx_audit_findings" -n lnxstudents 
  > bolt plan run "create_win_audit_findings" -n winstudents 

## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
