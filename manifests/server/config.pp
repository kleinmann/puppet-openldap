# Class: ldap::server::openldap::base
#
# This class sets up universal defaults between all types of 
# Operating Systems for the Initializion of OpenLDAP.
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
class ldap::server::config (
  $ssl,
  $ssl_ca,
  $ssl_cert,
  $ssl_key,
  $rootdn,
  $rootpw,
  $basedn,
  $domain,
) {
  File {
    owner => 'root',
    group => $ldap::params::lp_daemon_group,
    mode  => '0640',
  }

  file { "/etc/ldap-server":
    ensure  => file,
    content => 'openldap',
  }

  file { "${ldap::params::lp_openldap_slapd_conf_dir}/slapd.conf":
    ensure  => file,
    group   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/slapd.conf.erb')
  }

  file { "${ldap::params::lp_openldap_conf_dir}/slapd.conf":
    ensure  => file,
    group   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/slapd.conf.erb')
  }

  file {"${ldap::params::lp_openldap_conf_dir}":
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  ## Setup Initial OpenLDAP Database
  file { "${ldap::params::lp_openldap_var_dir}/DB_CONFIG":
    ensure  => $ensure,
    mode    => '0660',
    content => template('ldap/server/openldap/DB_CONFIG.erb'),
  }

  file { "${ldap::params::lp_openldap_var_dir}/base.ldif":
    ensure  => $ensure,
    owner   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/base.ldif.erb'),
    notify  => Exec["bootstrap-ldap"],
  }

  exec { "bootstrap-ldap":
    command   => "ldapadd -x -D ${rootdn},${basedn} -w ${rootpw} -f ${ldap::params::lp_openldap_var_dir}/base.ldif",
    path      => '/bin:/sbin:/usr/bin:/usr/sbin',
    user      =>  $ldap::params::lp_daemon_user,
    group     =>  $ldap::params::lp_daemon_group,
    logoutput => true,
    creates   => "${ldap::params::lp_openldap_var_dir}/id2entry.bdb",
    before    => Class['ldap::server::service'],
  }
}
