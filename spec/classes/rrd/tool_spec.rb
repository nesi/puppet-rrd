require 'spec_helper'

describe 'rrd::tool', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should contain_class('rrd::params')}
    it {should contain_package('rrdtool')}
  end
end
