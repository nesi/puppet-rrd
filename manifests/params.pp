class rrd::params {
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
    }
    default:{
      fail{"The OS family ${::osfamily} is not supported by the rrd module.": }
    }
  }
}