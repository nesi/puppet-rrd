# Class: rrd::bindings::php
class rrd::bindings::php (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::php_packages:
    ensure => $ensure,
  }

}
