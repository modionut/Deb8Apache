class git {

	package { ['git', 'git-flow']:
	  ensure => present,
	}
}
