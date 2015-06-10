require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|

  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.before :each do
    # Ensure that we don't accidentally cache facts and environment
    # between test cases.
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear
    Facter.clear_messages

    # Store any environment variables away to be restored later
    @old_env = {}
    ENV.each_key {|k| @old_env[k] = ENV[k]}

    if ENV['STRICT_VARIABLES'] == 'yes'
      Puppet.settings[:strict_variables]=true
    end
  end
end

shared_examples :compile, :compile => true do
  it { should compile.with_all_deps }
end

$supported_os = on_supported_os.map do |os, facts|
  os_expects = {}
  expects = {
    :cache_listen           => 'unix:/var/run/rrdcached.sock',
    :cache_journal_dir      => '/var/lib/rrdcached/journal/',
    :cache_timeout          => '1800',
    :cache_delay            => '1800',
    :cache_write_threads    => '4',
    :cache_jump_dir         => '/var/lib/rrdcached/db/',
    :cache_always_flush     => true,
    :cache_enable_corefiles => false,
    :cache_restrict_writes  => false,
    :cache_maxwait          => '30'
  }
  case facts[:osfamily]
  when 'Debian'
    expects.merge!( {
      :lib_package      => ['librrd4','librrd-dev'],
      :tool_package     => 'rrdtool',
      :cache_package    => 'rrdcached',
      :ruby_packages    => ['librrd-ruby'],
      :python_packages  => ['python-pyrrd','python-rrdtool'],
      :perl_packages    => ['librrds-perl','librrdp-perl','librrdtool-oo-perl'],
      :tcl_packages     => ['rrdtool-tcl'],
      :php_packages     => ['php5-rrd'],
      :cache_conf_file  => '/etc/default/rrdcached',
      :cache_service    => 'rrdcached'
    } )
  when 'RedHat'
    expects.merge!( {
      :lib_package      => false,
      :tool_package     => 'rrdtool',
      :cache_package    => 'rrdcached',
      :ruby_packages    => 'rrdtool-ruby',
      :python_packages  => 'rrdtool-python',
      :perl_packages    => 'rrdtool-perl',
      :tcl_packages     => 'rrdtool-tcl',
      :php_packages     => 'rrdtool-php',
      :cache_conf_file  => '/etc/default/rrdcached',
      :cache_service    => 'rrdcached'
    } )
  end

  os_expects = {
    :os      => os,
    :facts   => facts,
    :expects => expects
  }
  os_expects
end
