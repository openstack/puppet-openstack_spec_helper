# This file contains a module to return a default set of facts and supported
# operating systems for the tests in this module.
module OSDefaults
  def self.get_facts(extra_facts={})
    {
      :os_service_default => '<SERVICE DEFAULT>',
      :os_workers         => 2,
      :puppetversion      => Puppet.version
    }.merge(extra_facts)
  end

  def self.get_supported_os
    [
      { 'operatingsystem'        => 'CentOS',
        'operatingsystemrelease' => [ '8' ] },
      { 'operatingsystem'        => 'Ubuntu',
        'operatingsystemrelease' => [ '18.04' ] },
      { 'operatingsystem'        => 'Debian',
        'operatingsystemrelease' => [ '8' ] }
    ]
  end
end

# Make sure we include any helpers for spec tests.
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
