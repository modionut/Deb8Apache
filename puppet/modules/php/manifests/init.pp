class php {

	package { ['php5-fpm', 'php5-cli', 'php5-gd', 'php5-curl', 'php5-mcrypt', 'php5-mysql', 'php5-xdebug']:
	  ensure => present,
	}

	exec { "php5-fpm restart":
	  command => "/usr/sbin/service php5-fpm restart",
	  require => Package['php5-fpm'],
	}
	
	file { '/etc/php5/fpm/conf.d/05-opcache.ini':
	  ensure => absent,
	  notify => Exec['php5-fpm restart'],
	}

	service { 'php5-fpm':
	  ensure => running,
	  enable  => "true",
	  require => Package['php5-fpm'],
	}
	
	# Add php.ini template
	file { 'php5-fpm-conf':
	    path => '/etc/php5/fpm/php.ini',
	    ensure => file,
	    notify => Exec['php5-fpm restart'],
	    source => 'puppet:///modules/php/php.ini',
	}
	# Add php.ini template
	file { 'php5-xdebug-conf':
	    path => '/etc/php5/fpm/conf.d/20-xdebug.ini',
	    ensure => file,
	    notify => Exec['php5-fpm restart'],
	    require => Package['php5-xdebug'],
	    source => 'puppet:///modules/php/20-xdebug.ini',
	}
}
