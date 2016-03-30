class users {
  user {'fundamentals':
    ensure   => present,
    shell    => '/sbin/nologin',
  }
  
  include users::admins
}
