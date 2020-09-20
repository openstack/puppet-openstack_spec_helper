Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-openstack_spec_helper.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

Puppet-OpenStack Spec Helper
============================

This gem provides helper utilities for running rspec tests in the
[OpenStack Puppet Modules](https://wiki.openstack.org/wiki/Puppet).

Usage
-----

Include this gem in your Gemfile:

```
gem 'puppet-openstack_spec_helper',
  :git => 'https://opendev.org/openstack/puppet-openstack_spec_helper',
  :require => false
```

In your Rakefile, require the rake\_tasks library:

```
require 'puppet-openstack_spec_helper/rake_tasks'
```

Release notes for the project can be found at:
  https://docs.openstack.org/releasenotes/puppet-openstack_spec_helper

The project source code repository is located at:
  https://opendev.org/openstack/puppet-openstack_spec_helper

Contributors for the project can be found at:
  https://github.com/openstack/puppet-openstack_spec_helper/graphs/contributors

Developer documentation for the entire puppet-openstack project can be found at:
  https://docs.openstack.org/puppet-openstack-guide/latest/
