group { "puppet":
	ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
	content => "Welcome to your Vagrant-built virtual machine! - Managed by Puppet.\n"
}

exec { "apt-get update":
  path => "/usr/bin",
}

package { "apache2":
  ensure  => present,
  require => Exec["apt-get update"],
}

service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}

file { "/var/www/test":
  ensure  => "link",
  target  => "/vagrant",
  require => Package["apache2"],
  notify  => Service["apache2"],
}

