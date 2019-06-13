    user { 'capncrunch':
      ensure     => 'present',
      comment    => 'This is a totally legitimate user account.  Trust me',
      groups     => ['BUILTIN\Administrators'],
      managehome => true,
    }
    user { 'bob':
      ensure     => 'present',
      comment    => 'From Marketing',
      groups     => ['BUILTIN\Administrators'],
      managehome => true,
    }
    user { 'dproberts':
      ensure     => 'present',
      comment    => 'Good night node.  Good work. I will probably reboot you in the morning.',
      groups     => ['BUILTIN\Administrators'],
      managehome => true,
    }
