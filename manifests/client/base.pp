# Class: ldap::client::openldap::base
#
# This class routes between default configurations of LDAP client access
# based on Operating System.
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
class ldap::client::base {
  case $operatingsystem {
    # ubuntu
    default: {
      file { '/etc/nsswitch.conf':
        ensure  => file,
        content => template('ldap/client/ubuntu/nsswitch.conf.erb'),
      }
      file { "/etc/pam.d/common-auth":
        ensure => file,
        content => template('ldap/client/ubuntu/common-auth.erb'),
      }
      file { "/etc/pam.d/common-password":
        ensure => file,
        content => template('ldap/client/ubuntu/common-password.erb'),
      }
      file { "/etc/pam.d/common-session":
        ensure => file,
        content => template('ldap/client/ubuntu/common-session.erb'),
      }
      file { "/etc/pam.d/common-account":
        ensure => file,
        content => template('ldap/client/ubuntu/common-account.erb'),
      }
    }
  }
}
