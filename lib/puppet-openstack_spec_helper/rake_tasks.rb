# Function for Rakefile goes here
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'puppet_litmus/rake_tasks'
require 'json'

PuppetSyntax.exclude_paths ||= []
PuppetSyntax.exclude_paths << "spec/fixtures/**/*"
PuppetSyntax.exclude_paths << "pkg/**/*"
PuppetSyntax.exclude_paths << "vendor/**/*"
PuppetSyntax.fail_on_deprecation_notices = false
PuppetSyntax.check_hiera_keys = true
PuppetSyntax.check_hiera_data = true

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
  config.fail_on_warnings = true

  if File.exist?("#{Dir.pwd}/.puppet-lint.rc")
    config.disable_checks = []
  else
    config.disable_checks = [
      'anchor_resource',
      'check_unsafe_interpolations',
      'class_inherits_from_params_class',
      'only_variable_string',
      'parameter_types',
      'params_empty_string_assignment',
      'strict_indent',
    ]
  end
end

Rake::Task[:spec_prep].clear
desc 'Create the fixtures directory'
task :spec_prep do
  modname = JSON.parse(open('metadata.json').read)['name'].split('-')[1]

  # Allow to test the module with custom dependencies
  # like you could do with .fixtures file
  if ENV['PUPPETFILE']
    puppetfile = ENV['PUPPETFILE']
    if ENV['GEM_HOME']
      gem_home    = ENV['GEM_HOME']
      gem_bin_dir = "#{gem_home}" + '/bin/'
    else
      gem_bin_dir = ''
    end
    r10k += ["#{gem_bin_dir}r10k"]
    r10k += ['-v', 'DEBUG', 'puppetfile', 'install']
    r10k += ["--puppetfile", "#{puppetfile}"]
    r10k += ["--moduledir", "#{Dir.pwd}/spec/fixtures/modules"]
    sh(*r10k)
  else
  # otherwise, use official OpenStack Puppetfile
    zuul_branch = ENV['ZUUL_BRANCH'] || 'master'
    repo = 'openstack/puppet-openstack-integration'
    rm_rf(repo)
    if File.directory?("/home/zuul/src/opendev.org/#{repo}")
      sh("mkdir openstack || true")
      sh("cp -R /home/zuul/src/opendev.org/#{repo} #{repo}")
    else
      sh("git clone https://opendev.org/#{repo} #{repo}")
    end
    # Allow to a repository to have extra modules that are not
    # in puppet-openstack-integration
    if File.exist?("#{Dir.pwd}/Puppetfile_extras")
      sh("cat #{Dir.pwd}/Puppetfile_extras >> #{repo}/Puppetfile")
    end
    script = ['env']
    script += ["PUPPETFILE_DIR=#{Dir.pwd}/spec/fixtures/modules"]
    script += ["ZUUL_BRANCH=#{zuul_branch}"]
    script += ['bash', "#{repo}/install_modules_unit.sh"]
    sh(*script)
  end
  rm_rf("spec/fixtures/modules/#{modname}")
  ln_s(Dir.pwd, "spec/fixtures/modules/#{modname}")
  mkdir_p('spec/fixtures/manifests')
  touch('spec/fixtures/manifests/site.pp')
end

Rake::Task[:spec_clean].clear
desc 'Clean up the fixtures directory'
task :spec_clean do
  rm_rf('spec/fixtures/modules')
  rm_rf('openstack')
  if File.zero?('spec/fixtures/manifests/site.pp')
    rm_f('spec/fixtures/manifests/site.pp')
  end
end
