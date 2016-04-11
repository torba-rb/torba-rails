module Torba
  class Engine < Rails::Engine
    def self.setup(config = Rails.application.config)
      config.assets.paths.concat(Torba.load_path)
      unless using_sprockets4?
        config.assets.precompile.concat(Torba.non_js_css_logical_paths)
      end
    end

    def self.serve_static_files?(config = Rails.application.config)
      (config.respond_to?(:public_file_server) && config.public_file_server.enabled) ||
        (config.respond_to?(:serve_static_files) && config.serve_static_files) || # Rails 4
        (config.respond_to?(:serve_static_assets) && config.serve_static_assets) || # Rails 3
        ENV["RAILS_GROUPS"] == "assets" # Rails 3
    end

    initializer "torba.assets" do
      if Engine.serve_static_files?
        require "torba/verify"
        Engine.setup
      elsif defined?(Rake) && Rake.application.top_level_tasks.include?("assets:precompile")
        Engine.setup
      end
    end

    rake_tasks do
      require "torba/rake_task"
      Torba::RakeTask.new("torba:pack", :before => "assets:precompile")
    end

    def self.using_sprockets4?
      require 'sprockets/version' # Required for Rails 3.2.x with Sprockets 2.x.
      Gem::Version.new(Sprockets::VERSION) >= Gem::Version.new('4.x')
    end

    private_class_method :using_sprockets4?
  end
end
