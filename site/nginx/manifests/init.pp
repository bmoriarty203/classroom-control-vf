class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
    require => Package['nginx'],
  }
  
  file { '/var/www/index.html':
    ensure => file,
    require => File['/var/www'],
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
