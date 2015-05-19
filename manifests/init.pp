# Class: rrd
class rrd (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::lib_package:
    ensure => $ensure
  }

}
