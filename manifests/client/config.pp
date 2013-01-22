# Define: ldap::client::config
#
# This custom definition sets up all of the necessary configuration
# files to configure a client to AAA against LDAP servers.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *basedn* - Base DN for setting up the LDAP server.
# *ssl*     - Binary flag (true|false) Enable SSL support. *IN DEVELOPMENT*
# *servers* - Array of servers that can be connected to 
#
# Actions:
#
# 
# Requires:
#
# Sample Usage:
# Client Configuration:
# class { 'ldap::client::config':
#   servers => ['server-1', 'server-2'],
#   ssl     => false,
#   basedn => 'dc=puppetlabs,dc=test',
# }
class ldap::client::config (
  $basedn,
  $ssl,
  $servers
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  case $::operatingsystem {
    # ubuntu
    default: {
      file { '/etc/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/ldap.conf.erb'),
      }
      file { '/etc/ldap/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/ldap.conf.erb'), 
      }
    }
  }
}
