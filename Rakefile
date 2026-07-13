# frozen_string_literal: true

require 'puppetlabs_spec_helper/rake_tasks'

# Dynamically load Litmus tasks if the gem is present
begin
  require 'puppet_litmus/rake_tasks'
rescue LoadError
  # Gracefully fall back if running in a lean linting-only environment
end