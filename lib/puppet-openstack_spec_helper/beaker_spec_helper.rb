# Function for spec_helper_acceptance.rb goes here
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'puppet-openstack_spec_helper/shared_examples_acceptance'

run_puppet_install_helper

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(Dir.getwd))
  module_name = JSON.parse(open('metadata.json').read)['name'].split('-')[1]

  c.include PuppetOpenstackSpecHelpers::SmokeTest

  # Make sure proj_root is the real project root
  unless File.exists?("#{proj_root}/metadata.json")
    raise "bundle exec rspec spec/acceptance needs be run from module root."
  end

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|

      # install git
      install_package host, 'git'

      zuul_ref = ENV['ZUUL_REF']
      zuul_branch = ENV['ZUUL_BRANCH']
      zuul_url = ENV['ZUUL_URL']
      puppet_maj_version = ENV['PUPPET_MAJ_VERSION']

      repo = 'openstack/puppet-openstack-integration'

      # Start out with clean moduledir, don't trust r10k to purge it
      on host, "rm -rf /etc/puppet/modules/*"
      # Install dependent modules via git or zuul
      r = on host, "test -e /usr/zuul-env/bin/zuul-cloner", { :acceptable_exit_codes => [0,1] }
      if r.exit_code == 0
        zuul_clone_cmd = '/usr/zuul-env/bin/zuul-cloner '
        zuul_clone_cmd += '--cache-dir /opt/git '
        zuul_clone_cmd += "--zuul-ref #{zuul_ref} "
        zuul_clone_cmd += "--zuul-branch #{zuul_branch} "
        zuul_clone_cmd += "--zuul-url #{zuul_url} "
        zuul_clone_cmd += "git://git.openstack.org #{repo}"
        on host, zuul_clone_cmd
      else
        on host, "git clone https://git.openstack.org/#{repo} #{repo}"
      end

      on host, "ZUUL_REF=#{zuul_ref} ZUUL_BRANCH=#{zuul_branch} ZUUL_URL=#{zuul_url} PUPPET_MAJ_VERSION=#{puppet_maj_version} bash #{repo}/install_modules.sh"

      # Install the module being tested
      on host, "rm -fr /etc/puppet/modules/#{module_name}"
      puppet_module_install(:source => proj_root, :module_name => module_name)

      on host, "rm -fr #{repo}"
    end
  end
end
