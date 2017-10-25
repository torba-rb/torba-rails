require "bundler/gem_tasks"
require_relative "test/environment"

task :test do
  Bundler.with_clean_env do
    sh "BUNDLE_GEMFILE=test/#{Torba::Test::RAILS_VERSION}/Gemfile bundle install"

    $LOAD_PATH.unshift("test")
    Dir.glob("./test/**/*_test.rb").each { |file| require file}
  end
end

task :test_all do
  Torba::Test::SUPPORTED_RAILS_VERSIONS.each do |version|
    exit 1 unless sh "bundle exec rake test RAILS_VERSION=#{version}"
  end
end

task :default => :test
