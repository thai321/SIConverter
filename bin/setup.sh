#!/usr/bin/env sh
echo "Install Ruby Gem ..."
bundle install

echo "Setup model, database, and seeding ..."
rails db:reset

echo "Seeding data for testing..."
rails db:seed RAILS_ENV=test

echo "Run Test ..."
bundle exec rspec
