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
  spec.add_dependency 'puppetlabs_spec_helper', ['< 3.0.0']
  # NOTE(mwhahaha): rake 13.0.0 requires ruby > 2.1.0
  rake_version = RUBY_VERSION < '2.1.0' ? ['< 13.0.0'] : ['>= 13.0.0']
  spec.add_dependency 'rake', rake_version
  # NOTE(tkajinam): minitest 5.12.1 requires ruby > 2.3
  minitest_version = RUBY_VERSION < '2.3.0' ? ['< 5.12.1'] : ['>= 5.12.1']
  spec.add_dependency 'minitest', minitest_version

  puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? ENV['PUPPET_GEM_VERSION'] : ['~> 5.5']
  spec.add_dependency 'puppet', puppetversion
  spec.add_dependency 'rspec-puppet', ['~> 2.3.0']

  # TODO(aschultz): 1.9.5 requires ruby >= 2.1.0 which breaks on centos7
  rspec_puppet_facts_version = RUBY_VERSION < '2.1.0' ? ['>= 1.7.0', '< 1.9.5'] : ['>= 1.7.0']
  spec.add_dependency 'rspec-puppet-facts', rspec_puppet_facts_version
  spec.add_dependency 'metadata-json-lint'

  # NOTE(tkajinam): Use puppet-lint-param-docs 1.5.1 because stable branches are not compatible
  #                 with new rules enforced in 1.6.0
  spec.add_dependency 'puppet-lint-param-docs', ['= 1.5.1']

  # TODO(tobias-urdin): Use puppet-lint-absolute_classname-check >= 2.0.0 for Ruby version >= 2.1.0
  # when we have fixed all the absolute includes to relative.
  # https://github.com/voxpupuli/puppet-lint-absolute_classname-check#relative-class-name-inclusion
  puppet_lint_absolute_classname_version = RUBY_VERSION < '2.1.0' ? ['~> 1.0.0'] : ['~> 1.0.0']
  spec.add_dependency 'puppet-lint-absolute_classname-check', puppet_lint_absolute_classname_version

  # NOTE(tkajinam): puppet-lint-unquoted_string-check >= 2.0.0 requires ruby >= 2.4
  puppet_lint_unquoted_string_check_version = RUBY_VERSION < '2.4.0' ? ['~> 1.0.0'] : ['>= 2.0.0']
  spec.add_dependency 'puppet-lint-unquoted_string-check', puppet_lint_unquoted_string_check_version

  spec.add_dependency 'puppet-lint-leading_zero-check'
  spec.add_dependency 'json'
  spec.add_dependency 'webmock'
  spec.add_dependency 'etcdv3'

  # NOTE(tkajinam): pin rexml in CentOS7
  rexml_version = RUBY_VERSION < '2.4.0' ? ['< 3.2.5'] :  ['>= 3.2.5']
  spec.add_dependency 'rexml', rexml_version

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
  spec.add_dependency 'gettext', ['< 3.3.0']
  spec.add_dependency 'jwt', ['= 1.5.6']
  spec.add_dependency 'nokogiri', ['< 1.7.0']
  # fog-core 1.44.0 requires xmlrpc 0.3.0 which requires ruby 2.3.0 which is not available on centos7
  spec.add_dependency 'fog-core', ['!= 1.44.0']

  # NOTE(tobias-urdin): Pin signet to 0.11.0 as 0.12.0 requires ruby >= 2.4.0
  signet_version = RUBY_VERSION < '2.4.0' ? '~> 0.11.0' : '>= 0.11.0'
  spec.add_dependency 'signet', signet_version

  # NOTE(zhongshengping): Pin dry-inflector to 0.1.2 as 0.2.0 requires ruby >= 2.4.0
  dry_inflector_version = RUBY_VERSION < '2.4.0' ? '~> 0.1.2' : '>= 0.1.2'
  spec.add_dependency 'dry-inflector', dry_inflector_version

  # NOTE(zhongshengping): Pin oga to 2.15 as 3.0 requires ruby >= 2.4.0
  oga_version = RUBY_VERSION < '2.4.0' ? '~> 2.15' : '>= 2.15'
  spec.add_dependency 'oga', oga_version

  # dependencies that are needed to run beaker-rspec
  beaker_rspec_version = RUBY_VERSION < '2.1.8' ? '= 5.6.0' : '= 6.2.3'
  spec.add_dependency 'beaker-rspec', beaker_rspec_version

  # NOTE(tobias-urdin): When beaker_rspec_version is = 6.2.3 it depends on
  # beaker ~> 3.0 which resolves to 3.37.0 which depends on pry-byebug ~> 3.4.2
  # resolving to 3.4.3 that depends on pry ~> 0.13.0 which it doesn't support
  # so we should cap pry to 0.12.2 otherwise if beaker-rspec is 5.6.0 we
  # pin to 0.10.4
  # TODO(tobias-urdin): Evaulate/remove when we unpin beaker-rspec or beaker.
  pry_version = beaker_rspec_version == '= 6.2.3' ? '= 0.12.2' : '= 0.10.4'
  spec.add_dependency 'pry', pry_version

  # Pin beaker-puppet to 0.17.1 because 1.0.0 does not work with our older
  # beaker and beaker-puppet requirements.
  spec.add_dependency 'beaker-puppet', ['= 0.17.1']
  # Pin breaker-hiera since 0.2.0 fails with the rest of our stuff.
  spec.add_dependency 'beaker-hiera', ['= 0.1.1']
  spec.add_dependency 'beaker-puppet_install_helper'
  spec.add_dependency 'vagrant-wrapper'

  # NOTE(tobias-urdin): Pin r10k and cri gems since r10k 3.0.0
  # requires a cri version that must have ruby >= 2.3.0
  spec.add_dependency 'r10k', ['~> 2.6']
  spec.add_dependency 'cri', ['~> 2.6']
end
