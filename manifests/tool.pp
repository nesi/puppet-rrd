# Class: rrd::tool
class rrd::tool (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::tool_package:
    ensure => $ensure,
  }

}
