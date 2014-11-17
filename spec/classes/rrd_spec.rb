require 'spec_helper'

describe 'rrd', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should contain_class('rrd::params')}
    it {should contain_package('librrd4')}
  end
end
