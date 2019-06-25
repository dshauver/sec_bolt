plan sec_bolt::remediate_all(
  TargetSpec $nodes,
  Optional[String[1]] $disable_user = undef,
) {
  # This collects facts on nodes and update the inventory
  run_plan(facts, nodes => $nodes)

  $win_nodes = get_targets($nodes).filter |$n| { $n.facts['os']['name'] == 'Windows' }
  $centos_nodes = get_targets($nodes).filter |$n| { $n.facts['os']['name'] == 'CentOS' }
  #run_task(windows_task, $win_nodes)
  #run_task(centos_task, $centos_nodes)

#All nodes
  #Delete user
  apply($nodes) {
    user { 'capncrunch':
          ensure     => 'absent',
          managehome => true,
    }
  }

#Windows
  #Disable DPRoberts User
  run_task('sec_bolt::disable_win_user', disable_user => dproberts, $win_nodes)
  #Remove Bob's admin rights
  #run_task('sec_bolt::remove_admin_win', user => 'bob', $win_nodes)
  run_task('sec_bolt::remove_admin_win', $win_nodes)
  #uninstall Telnet Client
  run_command('Remove-WindowsFeature -name Telnet-Client', $win_nodes)
  #Set firewall service to automatic startup
  run_command('Set-Service MpsSvc -StartupType Automatic', $win_nodes)
  #Start firewall service
  run_command('Start-Service -name MpsSvc', $win_nodes)
  #Stop FTP Service
  run_command('Stop-Service -name FTPSVC', $win_nodes)
  #Disable FTP Service
  run_command('Set-Service FTPSVC -StartupType Disable', $win_nodes)

#LINUX
  #Disable DPRoberts User
  run_task('sec_bolt::disable_nix_user', $centos_nodes)
  #Remove Bob's admin rights
  run_task('sec_bolt::remove_admin_nix', $centos_nodes)
  #uninstall Telnet client
  run_command('yum remove telnet -y', $centos_nodes)
  #Stop FTP Service
  run_command('sudo systemctl stop vsftpd', $centos_nodes)
  #Disable FTP Service
  run_command('sudo systemctl disable vsftpd', $centos_nodes)
}
