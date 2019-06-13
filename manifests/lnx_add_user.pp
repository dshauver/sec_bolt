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
