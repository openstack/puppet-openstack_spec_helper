module PuppetOpenstackSpecHelpers
  module SmokeTest
    def smoke_test_named(file)
      smoke_manifest_file = example_file(file)
      File.read(smoke_manifest_file)
    end

    def project_root_directory
      RSpec::Core::RubyProject.root
    end

    private
    def example_file(file)
      smoke_manifest_file = ''
      found = true
      ['examples', 'tests'].each do |ex_dir|
        smoke_dir = File.join(project_root_directory, ex_dir)
        smoke_manifest_file = File.join(smoke_dir,
                                        file.sub(/\.pp$/, '') + '.pp')
        break if File.exist?(smoke_manifest_file)
        found = false
      end
      unless found
        raise ArgumentError,
              "Cannot find smoke manifest file '#{file}' in 'tests' or 'examples' directory"
      end
      smoke_manifest_file
    end
  end
end
