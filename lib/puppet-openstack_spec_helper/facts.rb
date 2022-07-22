require 'rspec-puppet-facts'
require 'rspec-puppet-utils'
require 'puppet-openstack_spec_helper/defaults'
include RspecPuppetFacts

RSpec.configure do |c|
  # add custom facts globally for anyone using rspec-puppet-facts
  add_custom_fact :os_service_default, '<SERVICE DEFAULT>'
  add_custom_fact :os_workers, '2'
  add_custom_fact :os_workers_heat_engine, '2'
  add_custom_fact :os_workers_keystone, '4'
end
