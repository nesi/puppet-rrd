require 'spec_helper'

describe 'rrd::bindings::php', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should include_class('rrd::params')}
    it {should contain_package('php5-rrd')}
  end
end