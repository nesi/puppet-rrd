# Class: rrd::bindings::ruby
class rrd::bindings::ruby (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::ruby_packages:
    ensure => $ensure,
  }

}
