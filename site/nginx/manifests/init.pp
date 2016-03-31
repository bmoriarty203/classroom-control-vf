class nginx (
$nginx_pkg = $nginx::params::nginx_pkg,
$nginx_file_owner = $nginx::params::nginx_file_owner,
$nginx_group_owner = $nginx::params::nginx_group_owner,
$nginx_root = $nginx::params::nginx_default_root,
$nginx_config_dir = $nginx::params::nginx_config_dir,
$nginx_logs_dir = $nginx::params::nginx_logs_dir,
$nginx_runas = $nginx::params::nginx_runas,
$nginx_name = 'nginx',
) inherits nginx::params {
 
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

  file { "${nginx_config_dir}/conf.d/default.conf":
    ensure => file,
    require => File["${nginx_config_dir}/nginx.conf"],
    content => template('nginx/default.conf.erb'),
  }
  
  service { $nginx_name:
    ensure => running,
    enable => true,
    require => File['/etc/nginx/conf.d/default.conf'],
  }
}
