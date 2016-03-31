class nginx::params {
	case $::osfamily {
		'redhat','debian' : {
			$nginx_pkg = 'nginx'
			$nginx_file_owner = 'root'
			$nginx_group_owner = 'root'
			$nginx_default_root = '/var/www'
			$nginx_config_dir = '/etc/nginx'
			$nginx_logs_dir = '/var/log/nginx'
		}
		'windows' : {
			$nginx_pkg = 'nginx-service'
			$nginx_file_owner = 'Administrator'
			$nginx_group_owner = 'Administrators'
			$nginx_default_root = 'C:/ProgramData/nginx/html'
			$nginx_config_dir = 'C:/ProgramData/nginx'
			$nginx_logs_dir = 'C:/ProgramData/nginx/logs'
		}
		default : {
		  fail("Module ${module_name} is not supported on ${::osfamily}")
		}
	}
	$nginx_runas = $::osfamily ? {
		'redhat' => 'nginx',
		'debian' => 'www-data',
		'windows' => 'nobody',
	}
}
