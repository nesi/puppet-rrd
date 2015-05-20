require 'spec_helper'

describe 'rrd', :type => :class do

  $supported_os.each do | os_expects |
    os      = os_expects[:os]
    facts   = os_expects[:facts]
    expects = os_expects[:expects]
    context "on #{os}" do
      let (:facts) { facts }
      describe "with no parameters" do
        it { should contain_class('rrd::params') }
        if expects[:lib_package]
          Array(expects[:lib_package]).each do | package |
            it { should contain_package(package).with_ensure('installed') }
          end
        end
      end
      describe "when ensure is absent" do
        let :params do
            { :ensure => 'absent'}
          end
        it { should contain_class('rrd::params') }
        if expects[:lib_package]
          Array(expects[:lib_package]).each do | package |
            it { should contain_package(package).with_ensure('absent') }
          end
        end
      end
    end
  end
  context "on and Unknown operating system" do
    let (:facts) do
      { :osfamily => 'Unknown' }
    end
    it { should raise_error(Puppet::Error,
      %r{The OS family Unknown is not supported by the rrd module.}
    ) }
  end
end
