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

export SCRIPT_DIR=$(cd `dirname $0` && pwd -P)
source $SCRIPT_DIR/functions

export PUPPET_VERSION=${PUPPET_VERSION:-7}
PUPPET_MAJOR_VERSION=`echo $PUPPET_VERSION | cut -c 1`
export PUPPET_GEM_VERSION="~> $PUPPET_MAJOR_VERSION"

install_gems

# run unit tests
$GEM_HOME/bin/bundle exec rake syntax
