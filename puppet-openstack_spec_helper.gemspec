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
  spec.add_dependency 'puppet-lint'
  spec.add_dependency 'puppetlabs_spec_helper'
  spec.add_dependency 'rake'
  spec.add_dependency 'minitest'

  puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? ENV['PUPPET_GEM_VERSION'] : ['>= 7.0']
  spec.add_dependency 'puppet', puppetversion

  rspec_puppet_version = ENV.key?('RSPEC_PUPPET_VERSION') ? ENV['RSPEC_PUPPET_VERSION'] : ['~> 2.10.0']
  spec.add_dependency 'rspec-puppet', rspec_puppet_version

  spec.add_dependency 'rspec-puppet-facts'
  spec.add_dependency 'rspec-puppet-utils'

  spec.add_dependency 'metadata-json-lint'
  spec.add_dependency 'puppet-lint-param-docs'
  spec.add_dependency 'puppet-lint-unquoted_string-check'
  spec.add_dependency 'puppet-lint-absolute_classname-check'
  spec.add_dependency 'puppet-lint-leading_zero-check'

  spec.add_dependency 'json'
  spec.add_dependency 'webmock'

  spec.add_dependency 'r10k', ['>= 3.0.0']

  spec.add_dependency 'bolt'
  spec.add_dependency 'puppet_litmus'
  spec.add_dependency 'serverspec'
end
