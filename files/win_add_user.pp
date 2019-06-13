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
