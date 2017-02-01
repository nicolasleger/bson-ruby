#!/bin/bash

set -o xtrace   # Write all commands first to stderr
set -o errexit  # Exit the script with error if any of the commands fail

# Supported/used environment variables:
#       RVM_RUBY      Define the Ruby version to test with, using its RVM identifier.
#                     For example: "ruby-2.3" or "jruby-9.1"

RVM_RUBY=${RVM_RUBY:-}

source ~/.rvm/scripts/rvm

if [ "$RVM_RUBY" == "ruby-head" ]; then
  rvm reinstall $RVM_RUBY
fi

if [ "$RVM_RUBY" == "ruby-2.3" ]; then
  sudo apt-get install libgmp3-dev
fi

rvm use $RVM_RUBY
gem install bundler

echo "Installing all gem dependencies"
bundle install
bundle exec rake clean

echo "Running specs"
bundle exec rake spec
