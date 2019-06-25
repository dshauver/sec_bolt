plan sec_bolt::setup(
  TargetSpec $nodes,
) {
  # This collects facts on nodes and update the inventory
  run_plan(facts, nodes => $nodes)

  $win_nodes = get_targets($nodes).filter |$n| { $n.facts['os']['name'] == 'Windows' }
  $centos_nodes = get_targets($nodes).filter |$n| { $n.facts['os']['name'] == 'CentOS' }
  #run_task(windows_task, $win_nodes)
  #run_task(centos_task, $centos_nodes)

  $nodes.apply_prep

#Windows
  apply($win_nodes) {
    user { 'capncrunch':
      ensure     => 'present',
      comment    => 'This is a totally legitimate user account.  Trust me',
      groups     => ['BUILTIN\Administrators'],
      password   => Sensitive('wh1$tl1ng1$4un!'),
      managehome => true,
    }
    user { 'bob':
      ensure     => 'present',
      comment    => 'From Marketing',
      groups     => ['BUILTIN\Administrators'],
      password   => Sensitive('$lu$h4und'),
      managehome => true,
    }
    user { 'dproberts':
      ensure     => 'present',
      comment    => 'Good night node.  Good work. I will probably reboot you in the morning.',
      groups     => ['BUILTIN\Administrators'],
      password   => Sensitive('w3$l3yt3h3rd'),
      managehome => true,
    }
  }

  run_task('sec_bolt::win_ftp_install', $win_nodes, 'Install FTP Feature')
  run_task('service', $win_nodes, 'Enable FTP service', {'action' => 'enable', 'name' => 'FTPSVC'})
  run_task('service', $win_nodes, 'Start FTP service', {'action' => 'start', 'name' => 'FTPSVC'})
  run_task('sec_bolt::win_telnet_install', $win_nodes, 'Install telnet client' )

#LINUX
  apply($centos_nodes) {
    user { 'capncrunch':
      ensure           => 'present',
      comment          => 'This is a totally legitimate user account.  Trust me.',
      groups           => ['adm', 'wheel'],
      home             => '/home/capncrunch',
      password_max_age => 99999,
      shell            => '/bin/bash',
      managehome       => true,
    }
    user { 'bob':
      ensure           => 'present',
      comment          => 'From marketing.',
      groups           => ['adm', 'wheel'],
      home             => '/home/bob',
      password_max_age => 99999,
      shell            => '/bin/bash',
      managehome       => true,
    }
    user { 'dproberts':
      ensure           => 'present',
      comment          => 'Good night node.  Good work. I will probably reboot you in the morning.',
      groups           => ['adm', 'wheel'],
      home             => '/home/dproberts',
      password_max_age => 99999,
      shell            => '/bin/bash',
      managehome       => true,
    }
  }

  run_task('package', $centos_nodes, 'Install vsftpd package', {'action' => 'install', 'name' => 'vsftpd'})
  run_task('service', $centos_nodes, 'Enable vsftpd service', {'action' => 'enable', 'name' => 'vsftpd'})
  run_task('service', $centos_nodes, 'Start vsftpd service', {'action' => 'start', 'name' => 'vsftpd'})
  run_task('package', $centos_nodes, 'Install telnet package', {'action' => 'install', 'name' => 'telnet'})

}
