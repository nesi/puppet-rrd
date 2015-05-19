# Class: rrd::bindings::tcl
class rrd::bindings::tcl (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::tcl_packages:
    ensure => $ensure,
  }

}
