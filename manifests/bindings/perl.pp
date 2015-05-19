# Class: rrd::bindings::perl
class rrd::bindings::perl (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::perl_packages:
    ensure => $ensure,
  }

}
