#!/bin/bash -ex

export SCRIPT_DIR=$(cd `dirname $0` && pwd -P)
source $SCRIPT_DIR/functions

install_gems

# run litmus tests
export RSPEC_DEBUG=true
$GEM_HOME/bin/bundle exec rake litmus:acceptance:localhost
