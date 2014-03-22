# == Class: mysql
#
# Installs MySQL server, sets config file, and loads database schema.
#
class mysql {
  package { ['mysql-server']:
    ensure => present;
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }

  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'];
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot status',
    command => "mysqladmin -uroot password root",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  exec { 'load-db_main':
    command => 'mysql -u root -proot < /vagrant/schema/db_main.sql',
    path    => ['/bin', '/usr/bin'],
    require => Exec['set-mysql-password'];
  }
}