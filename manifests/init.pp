# Class: ldap
#
# This module manages LDAP Server and Clients.
#
# Parameters:
# *client* - Binary Flag (true|false) to configure an LDAP Client
# *server* - Binary Flag (true|false) to configure an LDAP Server
# *ssl*         - (true|false) - enable SSL Support. *IN DEVELOPMENT*
# *rootdn* - String to give the DN of the LDAP administrator (server only)
# *rootpw* - String password for the LDAP administrator (server only)
# *basedn* - String to give the base DN of the LDAP domain
# *domain* - String to give the name of the managed LDAP domain (server only)
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# node 'server.puppetlabs.test' {
#   class { 'ldap':
#     server => 'true',
#     ssl    => 'false',
#     rootdn => 'cn=admin',
#     rootpw => 'password',
#     basedn => 'dc=puppetlabs,dc=test',
#     domain => 'puppetlabs.test',
#   }
# }
# node 'client.puppetlabs.test' {
#   class {'ldap':
#     client  => 'true',
#     ssl     => 'false',
#     basedn  => 'dc=puppetlabs,dc=test',
#     servers => ['ldap1.puppetlabs.test', 'ldap2.puppetlabs.test'],
#   }
# }
class ldap(
  $client   = false,
  $server   = false,
  $ssl      = false,
  $ssl_ca   = '',
  $ssl_cert = '',
  $ssl_key  = '',
  $rootdn   = '',
  $rootpw   = '',
  $basedn   = '',
  $domain   = '',
  $servers  = [],
) {
  include ldap::params

  package { $ldap::params::openldap_common_packages:
    ensure => present,
  }

  # Define Client Specific Information
  if $client == true {
    class { 'ldap::client':
      ensure  => 'present',
      ssl     => $ssl,
      basedn  => $basedn,
      servers => $servers,
    }
  }

  # Define Server Specific Information
  if $server == true {
    class { 'ldap::server': 
      ssl      => $ssl,
      ssl_ca   => $ssl_ca,
      ssl_cert => $ssl_cert,
      ssl_key  => $ssl_key,
      rootdn   => $rootdn,
      rootpw   => $rootpw,
      basedn   => $basedn,
      domain   => $domain,
    }
  }
}
