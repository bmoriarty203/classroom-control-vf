class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  $web_root => '/var/www'

  package { 'nginx':
    ensure => present,
  }
  
  file { $web_root:
    ensure => directory,
    require => Package['nginx'],
  }
  
  file { "${web_root}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    require => File['/var/www/index.html'],
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    require => File['/etc/nginx/nginx.conf'],
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    require => File['/etc/nginx/conf.d/default.conf'],
  }
}
