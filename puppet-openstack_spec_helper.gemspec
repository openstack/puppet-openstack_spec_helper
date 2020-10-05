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
  spec.add_dependency 'puppet-lint', ['2.3.6']
  spec.add_dependency 'puppetlabs_spec_helper'
  spec.add_dependency 'rake'
  spec.add_dependency 'minitest'

  puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? ENV['PUPPET_GEM_VERSION'] : ['>= 5.5']
  spec.add_dependency 'puppet', puppetversion

  # TODO(tobias-urdin): We need to bump this to 2.7.1 soon which will cause strict checking
  # of variables. This will break *a lot* of stuff because we are not properly including
  # classes in pre_condition in many places which causes undefined variables.
  rspec_puppet_version = ENV.key?('RSPEC_PUPPET_VERSION') ? ENV['RSPEC_PUPPET_VERSION'] : ['~> 2.3.0']
  spec.add_dependency 'rspec-puppet', rspec_puppet_version

  spec.add_dependency 'rspec-puppet-facts'

  spec.add_dependency 'metadata-json-lint', ['= 2.4.0']
  spec.add_dependency 'puppet-lint-param-docs', ['= 1.5.1']
  spec.add_dependency 'puppet-lint-unquoted_string-check', ['= 2.0.0']
  spec.add_dependency 'puppet-lint-absolute_classname-check', ['= 2.0.0']
  spec.add_dependency 'puppet-lint-leading_zero-check', ['= 0.1.1']

  spec.add_dependency 'json'
  spec.add_dependency 'webmock'
  spec.add_dependency 'etcdv3'

  # Force Netaddr 1.x as 2.x is not compatible
  # https://github.com/dspinhirne/netaddr-rb/issues/5
  spec.add_dependency 'netaddr', ['< 2.0.0']

  spec.add_dependency 'beaker-rspec'
  spec.add_dependency 'beaker-puppet'
  spec.add_dependency 'beaker-puppet_install_helper'
  spec.add_dependency 'vagrant-wrapper'

  spec.add_dependency 'r10k', ['>= 3.0.0']
end
