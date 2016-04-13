require "bundler/gem_tasks"

rails_versions = %w[3.2 4.1 4.2 5.0]

task :bundle do
  rails_versions.each do |version|
    Bundler.with_clean_env do
      sh "BUNDLE_GEMFILE=test/#{version}/Gemfile bundle install"
    end
  end
end

task :test do
  $LOAD_PATH.unshift("test")
  Dir.glob("./test/**/*_test.rb").each { |file| require file}
end

task :test_all do
  rails_versions.each do |version|
    Bundler.with_clean_env do
      sh "RAILS_VERSION=#{version} bundle exec rake test"
    end
  end
end

task :default => [:bundle, :test_all]
