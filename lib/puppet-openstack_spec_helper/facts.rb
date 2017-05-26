require 'rspec-puppet-facts'
require 'puppet-openstack_spec_helper/defaults'
include RspecPuppetFacts

RSpec.configure do |c|
  # TODO(aschultz): remove this after all tests are converted to OSDefaults
  # instead of referenceing @defaults_facts directly
  c.before :each do
    @default_facts = OSDefaults.get_facts
  end

  # add custom facts globally for anyone using rspec-puppet-facts
  add_custom_fact :os_service_default, '<SERVICE DEFAULT>'
  add_custom_fact :os_workers, '2'
end
