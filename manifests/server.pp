# Class: ldap::server
#
# This module manages LDAP Server Configuration 
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
class ldap::server(
  $ssl      = '',
  $ssl_ca   = '',
  $ssl_cert = '',
  $ssl_key  = '',
  $rootdn   = '',
  $rootpw   = '',
  $basedn   = '',
  $domain   = '',
) {
  class { 'ldap::server::package': 
    ssl => $ssl,
  }

  class { 'ldap::server::config': 
    ssl      => $ssl,
    ssl_ca   => $ssl_ca,
    ssl_cert => $ssl_cert,
    ssl_key  => $ssl_key,
    rootdn   => $rootdn,
    rootpw   => $rootpw,
    basedn   => $basedn,
    domain   => $domain,
    require  => Class['ldap::server::package'],
    notify   => Class['ldap::server::service'],
  }

  class { 'ldap::server::service': }
}

