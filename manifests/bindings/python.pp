# Class: rrd::bindings::python
class rrd::bindings::python (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::python_packages:
    ensure => $ensure,
  }

}
