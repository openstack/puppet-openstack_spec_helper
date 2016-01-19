#!/bin/bash -ex
# Copyright 2015 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

mkdir .bundled_gems
export GEM_HOME=`pwd`/.bundled_gems

# use puppet-nova to test the gem
if [ -e /usr/zuul-env/bin/zuul-cloner ] ; then
    /usr/zuul-env/bin/zuul-cloner --cache-dir /opt/git \
        git://git.openstack.org openstack/puppet-nova
else
    git clone git://git.openstack.org/openstack/puppet-nova openstack/puppet-nova
fi
cd openstack/puppet-nova

# Modify Gemfile to use local library and not the one on git
# so we can actually test the current state of the gem.
sed -i "s/.*git => 'https:\/\/git.openstack.org\/openstack\/puppet-openstack_spec_helper.*/      :path => '..\/..',/" Gemfile

# Install dependencies
gem install bundler --no-rdoc --no-ri --verbose
$GEM_HOME/bin/bundle install

# run unit tests
$GEM_HOME/bin/bundle exec rake spec SPEC_OPTS='--format documentation'
