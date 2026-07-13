source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development, :test, :system_tests do
  gem 'puppet_litmus', '>= 1.0'
  gem 'puppetlabs_spec_helper', '>= 3.0.0'
end

# Exclusively use openvox gem instead of puppet
openvox_version = ENV['OPENVOX_GEM_VERSION'] || ENV['PUPPET_GEM_VERSION']
if openvox_version
  gem 'openvox', openvox_version, require: false
else
  gem 'openvox', require: false
end

# Evaluate Gemfile.local and ~/.gemfile if they exist
extra_gemfiles = [
  "#{__FILE__}.local",
  File.join(Dir.home, '.gemfile'),
]

extra_gemfiles.each do |gemfile|
  if File.file?(gemfile) && File.readable?(gemfile)
    eval(File.read(gemfile), binding)
  end
end
# vim: syntax=ruby