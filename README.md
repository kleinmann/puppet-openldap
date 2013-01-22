# OpenLDAP module for clients and servers

DISCLAIMER: This is based on [jfryman/puppet-openldap](https://github.com/jfryman/puppet-openldap) with less flexibility and OS support.

Uwe Kleinmann <uwe@kleinmann.org>

This module installs PAM modules for OpenLDAP client nodes and can manage a single domain as an OpenLDAP server.
It is specifically for Ubuntu 12.10 and hasn't been tested with anything else.

# Usage

## Server
<pre>
node 'server.puppetlabs.test' {
  class { 'ldap':
    server => 'true',
    ssl    => 'false',
    rootdn => 'cn=admin',
    rootpw => 'password',
    basedn => 'dc=puppetlabs,dc=test',
    domain => 'puppetlabs.test',
  }
}
</pre>

## Client
<pre>
node 'client.puppetlabs.test' {
  class {'ldap':
    client  => 'true',
    ssl     => 'false',
    basedn  => 'dc=puppetlabs,dc=test',
    servers => ['ldap1.puppetlabs.test', 'ldap2.puppetlabs.test'],
  }
}
</pre>

