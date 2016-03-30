class nginx {
  case $::osfamily {
    'debian': {
      $nginx_pkg = 'nginx'
      $nginx_file_owner = 'root'
      $nginx_group_owner = 'root'
      $nginx_root = '/var/www'
      $nginx_config_dir = '/etc/nginx'
      $nginx_server_block_dir = '/etc/nginx/conf.d'
      $nginx_logs_dir = '/var/log/nginx'
      $nginx_name = 'nginx'
      $nginx_runas = 'www-data'
    }
    'windows': {
      $nginx_pkg = 'nginx-service'
      $nginx_file_owner = 'Administrator'
      $nginx_group_owner = 'Administrators'
      $nginx_root = 'C:/ProgramData/nginx/html'
      $nginx_config_dir = 'C:/ProgramData/nginx'
      $nginx_server_block_dir = 'C:/ProgramData/nginx/conf.d'
      $nginx_logs_dir = 'C:/ProgramData/nginx/logs'
      $nginx_name = 'nginx'
      $nginx_runas = 'nobody'
    }
    'redhat': {
      $nginx_pkg = 'nginx'
      $nginx_file_owner = 'root'
      $nginx_group_owner = 'root'
      $nginx_root = '/var/www'
      $nginx_config_dir = '/etc/nginx'
      $nginx_server_block_dir = '/etc/nginx/conf.d'
      $nginx_logs_dir = '/var/log/nginx'
      $nginx_name = 'nginx'
      $nginx_runas = 'nginx'
    }
    default: {
      fail("Operating system #{operatingsystem} is not supported.")
    }
  }
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  package { $nginx_pkg:
    ensure => present,
  }
  
  file { $nginx_root:
    ensure => directory,
    require => Package['nginx'],
  }
  
  file { "${nginx_root}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${nginx_config_dir}/nginx.conf":
    ensure => file,
    require => File["${nginx_root}/index.html"],
    content => template('nginx/nginx.conf.erb'),
  }

  file { "${nginx_server_block_dir}/default.conf":
    ensure => file,
    require => File["${nginx_config_dir}/nginx.conf"],
    content => template('nginx/default.conf.erb'),
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    require => File['/etc/nginx/conf.d/default.conf'],
  }
}
