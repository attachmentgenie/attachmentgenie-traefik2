# frozen_string_literal: true

require 'voxpupuli/test/spec_helper'

RSpec.configure do |c|
  c.before :each do
    Puppet.settings[:strict] = :warning
    Puppet.settings[:strict_variables] = true
  end
end
