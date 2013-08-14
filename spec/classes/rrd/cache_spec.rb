require 'spec_helper'

describe 'rrd::cache', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should include_class('rrd::params')}
    it {should contain_package('rrdcached')}
    it {should contain_service('rrdcached')}
    it {should contain_file('rrdcached.conf').with(
      'path'  => '/etc/default/rrdcached',
      )
    }
    it { should contain_file('rrdcached.conf').with_content %r{^DISABLE=0$} }
    it { should contain_file('rrdcached.conf').with_content %r{^ENABLE_COREFILES=0$} }
  end
end