# frozen_string_literal: true

require 'spec_helper'

describe 'traefik2::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        "class { 'traefik2':
          static_config  => {},
        }"
      end

      it { is_expected.to compile }
    end
  end
end
