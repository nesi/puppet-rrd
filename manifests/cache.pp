# Class: rrd::cache
class rrd::cache (
  $ensure           = 'installed',
  $service          = 'running',
  $listen           = $rrd::params::cache_listen,
  $gid              = undef,
  $journal_dir      = $rrd::params::cache_journal_dir,
  $timeout          = $rrd::params::cache_timeout,
  $delay            = $rrd::params::cache_delay,
  $write_threads    = $rrd::params::cache_write_threads,
  $jump_dir         = $rrd::params::cache_jump_dir,
  $always_flush     = $rrd::params::cache_always_flush,
  $enable_corefiles = $rrd::params::cache_enable_corefiles,
  $maxwait          = $rrd::params::cache_maxwait,
  $conf_file        = $rrd::params::cache_conf_file,
  $service_name     = $rrd::params::cache_service,
  $restrict_writes  = $rrd::params::restrict_writes,
) inherits rrd::params {

  package{$rrd::params::cache_package:
    ensure => $ensure,
  }


  case $service {
    'running':{
      $service_enable   = true
    }
    default:{
      $service_enable   = false
    }
  }

  file{'rrdcached.conf':
    ensure  => file,
    path    => $conf_file,
    mode    => '0644',
    content => template('rrd/rrdcached.conf.erb'),
    notify  => Service['rrdcached'],
    require => Package[$rrd::params::cache_package],
  }

  service{'rrdcached':
    ensure     => $service,
    name       => $service_name,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$rrd::params::cache_package],
  }

}
