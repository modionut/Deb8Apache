class apache2 {

	# Symlink guest /var/www/ to host /vagrant
	#file { "/var/www/html":
	#  ensure  => 'link',
	#	 force => true,
	#  target  => '/vagrant/project-code',
	#}


	package { 'apache2':
		ensure => 'present',
	}

	exec { "apache2 restart":
		command => "/usr/sbin/service apache2 restart",
		#  refreshonly => true,
	}

	service { 'apache2':
		ensure => running,
		enable  => "true",
		require => Package['apache2'],
	}


	# Add default.loc template
	file { 'vagrant-apache2-default':
		path => '/etc/apache2/sites-available/000-default.conf',
		ensure => link,
		require => Package['apache2'],
		source => 'puppet:///modules/apache2/000-default.conf',
	}



	file { '/etc/apache2/ssl':
		ensure => 'directory',
		require => Package['apache2'],
	}

	file { 'vagrant-apache2-ssl-default-crt':
		path => '/etc/apache2/ssl/server.crt',
		ensure => link,
		require => File['/etc/apache2/ssl'],
		source => 'puppet:///modules/apache2/server.crt',
	}

	file { 'vagrant-apache2-ssl-default-key':
		path => '/etc/apache2/ssl/server.key',
		ensure => link,
		require => File['/etc/apache2/ssl'],
		source => 'puppet:///modules/apache2/server.key',
	}


}

