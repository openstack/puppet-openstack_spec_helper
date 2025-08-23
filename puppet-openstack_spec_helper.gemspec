lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-openstack_spec_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet-openstack_spec_helper"
  spec.version       = PuppetOpenstackSpecHelper::Version::STRING
  spec.authors       = ["OpenStack Puppet Modules Team"]
  spec.description   = %q{Helpers for OpenStack module testing}
  spec.summary       = %q{Puppet-OpenStack spec helper}
  spec.homepage      = ""
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # dependencies that are needed to run puppet-lint and rspec-puppet
  spec.add_dependency 'puppet-lint', ['>= 2.0.0']
  spec.add_dependency 'puppetlabs_spec_helper'
  spec.add_dependency 'rake'
  spec.add_dependency 'minitest'

  puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? ENV['PUPPET_GEM_VERSION'] : ['>= 7.0']
  spec.add_dependency 'puppet', puppetversion

  if ENV.key?('RSPEC_PUPPET_VERSION')
    rspec_puppet_version = ENV['RSPEC_PUPPET_VERSION']
    spec.add_dependency 'rspec-puppet', rspec_puppet_version
  else
    spec.add_dependency 'rspec-puppet'
  end

  spec.add_dependency 'rspec-puppet-facts'
  spec.add_dependency 'rspec-puppet-utils'

  spec.add_dependency 'metadata-json-lint'
  spec.add_dependency 'voxpupuli-puppet-lint-plugins', '~> 6.0'

  spec.add_dependency 'json'
  spec.add_dependency 'webmock'

  spec.add_dependency 'r10k', ['>= 3.0.0']

  spec.add_dependency 'bolt'
  spec.add_dependency 'puppet_litmus'
  spec.add_dependency 'serverspec'

  spec.add_dependency 'ruby-augeas'
end
