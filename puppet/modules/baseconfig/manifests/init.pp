# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }
  
  file { '/etc/motd':
 	content => "Welcome to your Vagrant-built virtual machine! - Managed by Puppet.\n"
  }
  
}
