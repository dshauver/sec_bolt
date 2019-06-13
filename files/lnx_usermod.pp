user { 'capncrunch':
  ensure           => 'absent',
}
user { 'bob':
  groups           => [],
}
user { 'dproberts':
  shell            => '/bin/false',
}
