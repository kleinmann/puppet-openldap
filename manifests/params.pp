# Class: ldap::params
#
# This module manages LDAP paramaters
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
# This class file is not called directly
class ldap::params {

  case $::operatingsystem {
    # ubuntu
    default: {
      $lp_daemon_user = 'openldap'
      $lp_daemon_group = 'openldap'
      $lp_openldap_run_dir = '/var/run/slapd'
      $lp_openldap_service = 'slapd'
      $lp_openldap_conf_dir = '/etc/ldap'
      $lp_openldap_slapd_conf_dir = '/usr/share/slapd'
      $lp_openldap_modulepath = '/usr/lib/ldap'

      case $::operatingsystem {
        # ubuntu
        default: {
          $lp_openldap_var_dir = '/var/lib/ldap'
        }
      }

      case $::lsbdistcodename {
        # quantal
        default: {
          $openldap_packages = ['slapd']
          $openldap_client_packages = ['libnss-ldap']
          $openldap_common_packages = ['ldap-utils']
        }
      }
    }
  }
  $lp_openldap_allow_ldapv2 = 'false'
  $lp_openldap_loglevel     = '8'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
}
