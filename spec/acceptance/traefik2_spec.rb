require 'spec_helper_acceptance'

describe 'default parameters', if: ['debian', 'redhat', 'ubuntu'].include?(os[:family]) do
  let(:pp) do
    <<-PUPPETCODE
      class { ::traefik2: }
    PUPPETCODE
  end

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe file("/etc/traefik2/config.yaml") do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match %r{filePath: "/var/log/traefik2/access.log"} }
  end

  describe port(80) do
    it { is_expected.to be_listening }
  end
end