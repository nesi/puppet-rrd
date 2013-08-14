# Class: rrd::cache
#
# This module manages the rrd cache daemon packages (rrdcached).
#
# Note: This class does not require the rrd class, as the rrd
# libraries will be installed as dependencies.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include rrd::cache

# This file is part of the rrd Puppet module.
#
#     The rrd Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The rrd Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the rrd Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
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
  $service_name     = $rrd::params::cache_service
) inherits rrd::params {

  package{$rrd::params::cache_package:
    ensure => $ensure,
  }


  case $service {
    'stopped':{
      $service_enable   = false
    }
    'running':{
      $service_enable   = true
    }
  }

  file{'rrdcached.conf':
    ensure  => file,
    path    => $conf_file,
    mode    => 0644,
    content => template('rrd/rrdcached.conf.erb'),
    notify  => Service['rrdcached'],
    require => Package[$rrd::params::cache_package],
  }

  service{'rrdcached':
    name        => $service_name,
    ensure      => $service,
    enable      => $service_enable,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package[$rrd::params::cache_package],
  }

}