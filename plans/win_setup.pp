plan sec_bolt::win_setup (
  TargetSpec $nodes
) {
  $nodes.apply_prep
  apply($nodes) {
    if($facts['os']['family'] == 'windows') {
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
  }

  run_task('sec_bolt::win_ftp_install', $nodes, 'Install FTP Feature')
  run_task('service', $nodes, 'Enable FTP service', {'action' => 'enable', 'name' => 'FTPSVC'})
  run_task('service', $nodes, 'Start FTP service', {'action' => 'start', 'name' => 'FTPSVC'})
  run_task('sec_bolt::win_telnet_install', $nodes, 'Install telnet client' )
}
