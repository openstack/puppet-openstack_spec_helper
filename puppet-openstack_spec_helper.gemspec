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
  # NOTE(mwhahaha): pinning to 2.3.0 as 2.3.1 just fails siliently
  spec.add_dependency 'puppet-lint', ['2.3.0']
  spec.add_dependency 'puppetlabs_spec_helper'

  puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? ENV['PUPPET_GEM_VERSION'] : ['~> 5.5']
  spec.add_dependency 'puppet', puppetversion

  spec.add_dependency 'rspec-puppet', ['~> 2.3.0']
  spec.add_dependency 'rspec-puppet-facts', ['>= 1.7.0']
  spec.add_dependency 'metadata-json-lint'
  spec.add_dependency 'puppet-lint-param-docs'
  spec.add_dependency 'puppet-lint-absolute_classname-check'
  spec.add_dependency 'puppet-lint-unquoted_string-check'
  spec.add_dependency 'puppet-lint-leading_zero-check'
  spec.add_dependency 'json'
  spec.add_dependency 'webmock'
  spec.add_dependency 'etcdv3'

  # grpc 1.18 requires ruby >= 2.2
  grpc_rspec_version = RUBY_VERSION < '2.3.0' ? '~> 0.9': '~> 1.0'
  spec.add_dependency 'grpc', grpc_rspec_version

  # Force net-telnet 0.1.1 as 0.2.0 requires ruby >= 2.3.0 which
  # CentOS does not provide.
  spec.add_dependency 'net-telnet', ['= 0.1.1']

  # Force Netaddr 1.x as 2.x is not compatible
  # https://github.com/dspinhirne/netaddr-rb/issues/5
  spec.add_dependency 'netaddr', ['< 2.0.0']

  # Things that get pinned because we can't have nice things (new ruby > 2.0)
  spec.add_dependency 'fast_gettext', ['< 1.2.0']
  spec.add_dependency 'jwt', ['= 1.5.6']
  spec.add_dependency 'nokogiri', ['< 1.7.0']
  # fog-core 1.44.0 requires xmlrpc 0.3.0 which requires ruby 2.3.0 which is not available on centos7
  spec.add_dependency 'fog-core', ['!= 1.44.0']

  # dependencies that are needed to run beaker-rspec
  beaker_rspec_version = RUBY_VERSION < '2.1.8' ? '= 5.6.0' : '= 6.2.3'
  spec.add_dependency 'beaker-rspec', beaker_rspec_version
  # Pin beaker-puppet to 0.17.1 because 1.0.0 does not work with our older
  # beaker and beaker-puppet requirements.
  spec.add_dependency 'beaker-puppet', ['= 0.17.1']
  spec.add_dependency 'beaker-puppet_install_helper'
  spec.add_dependency 'vagrant-wrapper'

  # NOTE(tobias-urdin): Pin r10k and cri gems since r10k 3.0.0
  # requires a cri version that must have ruby >= 2.3.0
  spec.add_dependency 'r10k', ['~> 2.6']
  spec.add_dependency 'cri', ['~> 2.6']
end
