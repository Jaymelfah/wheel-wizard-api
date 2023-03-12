#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:prepare
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed