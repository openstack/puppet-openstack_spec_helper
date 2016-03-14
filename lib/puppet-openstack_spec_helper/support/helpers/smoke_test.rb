module PuppetOpenstackSpecHelpers
  module SmokeTest
    def smoke_test_named(file)
      smoke_dir = File.join(project_root_directory, 'tests')
      smoke_manifest_file = File.join(smoke_dir,
                                      file.sub(/\.pp$/, '') + '.pp')

      unless File.exists?(smoke_manifest_file)
        raise ArgumentError,
              "Cannot find smoke manifest file '#{smoke_manifest_file}'"
      end
      File.read(smoke_manifest_file)
    end

    def project_root_directory
      RSpec::Core::RubyProject.root
    end
  end
end
