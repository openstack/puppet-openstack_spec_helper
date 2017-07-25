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
  spec.add_dependency 'puppet-lint', ['~> 2.3.0']
  spec.add_dependency 'puppetlabs_spec_helper'
  spec.add_dependency 'rspec-puppet', ['~> 2.2.0']
  spec.add_dependency 'rspec-puppet-facts', ['>= 1.7.0']
  spec.add_dependency 'metadata-json-lint'
  spec.add_dependency 'puppet-lint-param-docs'
  spec.add_dependency 'puppet-lint-absolute_classname-check'
  spec.add_dependency 'puppet-lint-unquoted_string-check'
  spec.add_dependency 'puppet-lint-leading_zero-check'
  spec.add_dependency 'json'
  spec.add_dependency 'netaddr'
  spec.add_dependency 'webmock'
  spec.add_dependency 'etcdv3'

  # Things that get pinned because we can't have nice things (new ruby > 2.0)
  spec.add_dependency 'fast_gettext', ['< 1.2.0']
  spec.add_dependency 'nokogiri', ['< 1.7.0']
  # fog-core 1.44.0 requires xmlrpc 0.3.0 which requires ruby 2.3.0 which is not available on centos7
  spec.add_dependency 'fog-core', ['!= 1.44.0']

  # Beaker 3.0.0 fails to run in Puppet Openstack CI
  # LoadError: cannot load such file -- serverspec
  # While we're investigating it, let's pin Beaker to 2.x releases.
  spec.add_dependency 'beaker', ['< 3.0.0']

  # dependencies that are needed to run beaker-rspec
  spec.add_dependency 'beaker-rspec'
  spec.add_dependency 'beaker-puppet_install_helper'
  spec.add_dependency 'vagrant-wrapper'
  spec.add_dependency 'r10k'
end
