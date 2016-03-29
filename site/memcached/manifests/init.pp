class memcached {
  package {'memcached';
    ensure    => present,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure    => file,
    owner     => 'root',
    group     => 'root',
    require   => Package['memcached'],
    source    => 'puppet:///modules/memcached/memcached',
  }
  
  service { 'memcached':
    ensure    => running,
    enable    => true,
    require   => File['/etc/sysconfig/memcached'],
  }
}
