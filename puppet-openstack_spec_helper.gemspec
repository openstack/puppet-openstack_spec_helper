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
  spec.add_dependency 'puppetlabs_spec_helper'
  spec.add_dependency 'rspec-puppet', ['~> 2.2.0']
  spec.add_dependency 'rspec-puppet-facts'
  spec.add_dependency 'metadata-json-lint'
  spec.add_dependency 'puppet-lint-param-docs'
  # https://github.com/voxpupuli/puppet-lint-absolute_classname-check/issues/6
  spec.add_dependency 'puppet-lint-absolute_classname-check', ['0.1.3']
  spec.add_dependency 'puppet-lint-absolute_template_path'
  spec.add_dependency 'puppet-lint-trailing_newline-check'
  spec.add_dependency 'puppet-lint-unquoted_string-check'
  spec.add_dependency 'puppet-lint-leading_zero-check'
  spec.add_dependency 'puppet-lint-variable_contains_upcase'
  spec.add_dependency 'puppet-lint-numericvariable'
  spec.add_dependency 'json'
  spec.add_dependency 'netaddr'
  spec.add_dependency 'webmock'
  # json_pure 2.0.2 requires ruby >= 2.0 and we don't have it on Ubuntu Trusty
  spec.add_dependency 'json_pure', ['2.0.1']

  # dependencies that are needed to run beaker-rspec
  spec.add_dependency 'beaker-rspec'
  spec.add_dependency 'beaker-puppet_install_helper'
  spec.add_dependency 'r10k'
end
