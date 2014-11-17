require 'spec_helper'

describe 'rrd::bindings::perl', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should contain_class('rrd::params')}
    it {should contain_package('librrds-perl')}
    it {should contain_package('librrdp-perl')}
    it {should contain_package('librrdtool-oo-perl')}
  end
end
