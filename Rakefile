require "bundler/gem_tasks"
require_relative "test/environment"

task :test do
  Bundler.with_clean_env do
    sh "bundle install --gemfile=test/#{Torba::Test::RAILS_VERSION}/Gemfile #{"--path=vendor/bundle" if ENV["TRAVIS"]}"
    $LOAD_PATH.unshift("test")
    require_relative "test/acceptance_test"
  end
end

task :test_all do
  Torba::Test::SUPPORTED_RAILS_VERSIONS.each do |version|
    exit 1 unless sh "bundle exec rake test RAILS_VERSION=#{version}"
  end
end

task :default => :test
