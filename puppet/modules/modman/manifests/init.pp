# == Class: modman
#
# This class installs modman, the Magento module manager.
#
# === Parameters
#
# All of the variables are optional and should only be changed if you
# would like to install modman on a location that is different from the default
# and from a repository from another location.
#
# [*install_dest*]
#   By default modman is downloaded into the folder /usr/share/modman. If you would
#   like to download modman into another folder you can edit this parameter.
#
# [*repository*]
#   modman is downloaded from the repository https://github.com/colinmollenhour/modman
#   but if you would like to get modman from another repository then you can
#   pass that repository to this parameter.
#
# [*exec_location*]
#   The executable is configured in /usr/bin by default, if you would like to
#   launch modman from another executable path then pass that path to the
#   exec_location parameter.
#
# === Examples
#
#  class { 'modman': } # for installation with default parameters.
#
#  class { 'modman':
#    install_dest  => '/usr/share/modman',
#    repository    => 'https://github.com/colinmollenhour/modman',
#    exec_location => '/usr/bin/',
#  }
#
# === Authors
#
# Dimitri Steyaert <dimitri@steyaert.be>
#
# === Copyright
#
# Copyright 2015 Dimitri Steyaert.
#
class modman (
	$install_dest  = '/usr/share/modman',
	$repository    = 'https://github.com/colinmollenhour/modman',
	$exec_location = '/usr/bin/',
) {
	exec { 'clone-modman':
		creates   => $install_dest,
		command   => "git clone ${repository} ${install_dest}",
		path      => ['/usr/local/bin', '/usr/bin'],
		logoutput => true,
		require   => Package['git'],
	}
	if ! defined(Package['git']) {
		package { 'git':
			ensure => installed,
		}
	}
	file { "${exec_location}/modman":
		ensure  => "${install_dest}/modman",
		require => Exec['clone-modman'],
	}
	file { '/etc/bash_completion.d/modman':
		ensure  => "${install_dest}/bash_completion",
		require => Exec['clone-modman'],
	}
}