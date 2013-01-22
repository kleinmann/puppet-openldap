# Class: ldap::client
#
# This module manages LDAP client Configuration 
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly.
class ldap::client(
  $ensure = 'present',
  $ssl,
  $basedn,
  $servers,
) {
  Class {
    ensure => $ensure,
  }

  class { 'ldap::client::package': }

  class { 'ldap::client::base':
    ssl     => $ssl,
    require => Class['ldap::client::package'],
    notify  => Class['ldap::client::config'],
  }

  class { 'ldap::client::config':
    ssl     => $ssl,
    basedn => $basedn,
    servers => $servers,
    require => Class['ldap::client::base'],
    notify  => Class['ldap::client::service'],
  }

  class { 'ldap::client::service': }
}
