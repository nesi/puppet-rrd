# Defaults and variables
class rrd::params {

  $cache_listen           = 'unix:/var/run/rrdcached.sock'
  $cache_journal_dir      = '/var/lib/rrdcached/journal/'
  $cache_timeout          = '1800'
  $cache_delay            = '1800'
  $cache_write_threads    = '4'
  $cache_jump_dir         = '/var/lib/rrdcached/db/'
  $cache_always_flush     = true
  $cache_enable_corefiles = false
  $cache_restrict_writes  = false
  $cache_maxwait          = '30'

  case $::osfamily {
    Debian:{
      $lib_package      = 'librrd4'
      $tool_package     = 'rrdtool'
      $cache_package    = 'rrdcached'
      $ruby_packages    = ['librrd-ruby']
      $python_packages  = ['python-pyrrd','python-rrdtool']
      $perl_packages    = ['librrds-perl','librrdp-perl','librrdtool-oo-perl']
      $tcl_packages     = ['rrdtool-tcl']
      $php_packages     = ['php5-rrd']
      $cache_conf_file  = '/etc/default/rrdcached'
      $cache_service    = 'rrdcached'
    }
    default:{
      fail("The OS family ${::osfamily} is not supported by the rrd module.")
    }
  }
}
