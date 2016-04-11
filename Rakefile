require "bundler/gem_tasks"

rails_versions = %w[3.2 4.2 5.0]

task :test do
  version = ENV["RAILS_VERSION"] || rails_versions.last
  Bundler.with_clean_env do
    sh "BUNDLE_GEMFILE=test/#{version}/Gemfile bundle install"
  end

  $LOAD_PATH.unshift("test")
  Dir.glob("./test/**/*_test.rb").each { |file| require file}
end

task :test_all do
  rails_versions.each do |version|
    exit 1 unless sh "bundle exec rake test RAILS_VERSION=#{version}"
  end
end

task :default => :test_all
