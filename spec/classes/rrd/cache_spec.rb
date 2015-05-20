require 'spec_helper'

describe 'rrd::cache', :type => :class do
  $supported_os.each do | os_expects |
    os      = os_expects[:os]
    facts   = os_expects[:facts]
    expects = os_expects[:expects]
    context "on #{os}" do
      let (:facts) { facts }
      describe "with no parameters" do
        it { should contain_class('rrd::params') }
        if expects[:cache_package]
          Array(expects[:cache_package]).each do | package |
            it { should contain_package(package).with_ensure('installed') }
          end
        end
        it { should contain_file('rrdcached.conf').with(
          'path'  => expects[:cache_conf_file]
        ) }
        if expects[:cache_package].is_a?(Array)
          require_string = Array(expects[:cache_package]).map { |pkg| "Package[#{pkg}]"}
        else
          require_string = "Package[#{expects[:cache_package]}]"
        end
        it { should contain_service('rrdcached').with(
          'ensure'     => 'running',
          'name'       => expects[:cache_service],
          'enable'     => true,
          'hasstatus'  => true,
          'hasrestart' => true,
          'require'    => require_string
        ) }
        it 'should start rrdcached at boot time' do
          should contain_file('rrdcached.conf').with_content %r{^DISABLE=0$}
        end
        it 'should configure 30s for maxwait' do
          should contain_file('rrdcached.conf').with_content %r{^MAXWAIT=30$}
        end
        it 'should not enable core rrdcached files' do
          should contain_file('rrdcached.conf').with_content %r{^ENABLE_COREFILES=0$}
        end
        it 'should configure 4 write threads' do
          should contain_file('rrdcached.conf').with_content %r{-t 4}
        end
        it 'should configure timeout to 1800' do
          should contain_file('rrdcached.conf').with_content %r{-w 1800}
        end
        it 'should configure delay to 1800' do
          should contain_file('rrdcached.conf').with_content %r{-z 1800}
        end
        it 'should configure journal directory' do
          should contain_file('rrdcached.conf').with_content %r{-j /var/lib/rrdcached/journal/}
        end
        it 'should not enable gid settings' do
          should_not contain_file('rrdcached.conf').with_content %r{-s}
        end
        it 'should configure listen address (socket)' do
          should contain_file('rrdcached.conf').with_content %r{-l unix:/var/run/rrdcached.sock}
        end
        it 'should configure flush param' do
          should contain_file('rrdcached.conf').with_content %r{-F}
        end
        it 'should configure jump directory' do
          should contain_file('rrdcached.conf').with_content %r{-b /var/lib/rrdcached/db/}
        end
        it 'should not restrict writes' do
          should_not contain_file('rrdcached.conf').with_content %r{-B}
        end
      end
      describe "when ensure is absent" do
        let :params do
            { :ensure => 'absent'}
          end
        it { should contain_class('rrd::params') }
        if expects[:cache_package]
          Array(expects[:cache_package]).each do | package |
            it { should contain_package(package).with_ensure('absent') }
          end
        end
      end
      context 'with custom parameters' do
        let(:params)  do
          { :listen           => 'unix:/blah',
            :gid              => '42',
            :journal_dir      => '/srv/rrdcached',
            :timeout          => '1010',
            :delay            => '1337',
            :write_threads    => '7',
            :jump_dir         => '/srv/foo',
            :always_flush     => false,
            :enable_corefiles => '1',
            :maxwait          => '666',
            :conf_file        => '/srv/bah.conf',
            :restrict_writes  => true,
          }
        end
        it 'should configure 666s for maxwait' do
          should contain_file('rrdcached.conf').with_content %r{^MAXWAIT=666$}
        end
        it 'should enable core rrdcached files' do
          should contain_file('rrdcached.conf').with_content %r{^ENABLE_COREFILES=1$}
        end
        it 'should configure 7 write threads' do
          should contain_file('rrdcached.conf').with_content %r{-t 7}
        end
        it 'should configure timeout to 1010' do
          should contain_file('rrdcached.conf').with_content %r{-w 1010}
        end
        it 'should configure delay to 1337' do
          should contain_file('rrdcached.conf').with_content %r{-z 1337}
        end
        it 'should configure journal directory' do
          should contain_file('rrdcached.conf').with_content %r{-j /srv/rrdcached}
        end
        it 'should enable gid settings' do
          should contain_file('rrdcached.conf').with_content %r{-s 42}
        end
        it 'should configure listen address (socket)' do
          should contain_file('rrdcached.conf').with_content %r{-l unix:/blah}
        end
        it 'should not configure flush param' do
          should_not contain_file('rrdcached.conf').with_content %r{-F}
        end
        it 'should configure jump directory' do
          should contain_file('rrdcached.conf').with_content %r{-b /srv/foo}
        end
        it 'should restrict writes' do
          should contain_file('rrdcached.conf').with_content %r{-B}
        end
      end
    end
  end
end
