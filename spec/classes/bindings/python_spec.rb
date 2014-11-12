require 'spec_helper'

describe 'rrd::bindings::python', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
      }
    end
    it {should contain_class('rrd::params')}
    it {should contain_package('python-pyrrd')}
    it {should contain_package('python-rrdtool')}
  end
end
