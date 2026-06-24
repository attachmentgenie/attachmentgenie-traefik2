require 'spec_helper'

describe 'traefik2::user' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:pre_condition) do
        <<-EOF
        class traefik2 {
          $user     = 'traefik'
          $group    = 'traefik'
          $data_dir = '/var/lib/traefik2'
        }
        include traefik2
        EOF
      end

      it { is_expected.to compile }
      it { is_expected.to contain_group('traefik').with(
        'ensure' => 'present',
        'system' => true,
      )}
      it { is_expected.to contain_user('traefik').with(
        'ensure'     => 'present',
        'system'     => true,
        'gid'        => 'traefik',
        'shell'      => '/usr/sbin/nologin',
        'managehome' => false,
      )}
    end
  end
end
