Team and repository tags
========================

[![Team and repository tags](http://governance.openstack.org/badges/puppet-openstack_spec_helper.svg)](http://governance.openstack.org/reference/tags/index.html)

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
  :git => 'https://git.openstack.org/openstack/puppet-openstack_spec_helper',
  :require => false
```

In your Rakefile, require the rake\_tasks library:

```
require 'puppet-openstack_spec_helper/rake_tasks'
```

Instructions for using `puppet-openstack_spec_helper/beaker_spec_helper` in
`spec/spec_helper_acceptance.rb` to come soon.
