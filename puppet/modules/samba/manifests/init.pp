class samba {

	exec { "samba restart":
		command => "/etc/init.d/samba restart",
	}

	package { ['samba']:
	  ensure => present,
	}

	file { 'samba-conf':
		path => '/etc/samba/smb.conf',
		ensure => file,
		require => Package['samba'],
		notify => Exec['samba restart'],
		source => 'puppet:///modules/samba/smb.conf',
	}

}
