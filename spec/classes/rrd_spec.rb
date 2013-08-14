require 'spec_helper'

describe 'rrd', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should include_class('rrd::params')}
    it {should include_package('librrd4')}
  end
end