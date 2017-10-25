require "test_helper"
require "open3"

module Torba
  class RailsTest < Minitest::Test
    def test_verify_runs_in_dev_with_default_settings
      out, err, status = run_project_cmd(%{bin/rails runner 'puts "hello"'})
      refute status.success?, out
      assert_includes err, "Torba::Errors::MissingPackages"

      out, err, status = run_project_cmd(%{bundle exec torba pack})
      assert status.success?, err
      assert_includes out, "Torba has been packed!"

      out, err, status = run_project_cmd(%{bin/rails runner 'puts "hello"'})
      assert status.success?, err
      assert_includes out, "hello"
    end

    def test_verify_runs_in_test_with_default_settings
      out, err, status = run_project_cmd(%{bin/rails runner 'puts "hello"'}, "RAILS_ENV" => "test")
      refute status.success?, out
      assert_includes err, "Torba::Errors::MissingPackages"

      out, err, status = run_project_cmd(%{bundle exec torba pack})
      assert status.success?, err
      assert_includes out, "Torba has been packed!"

      out, err, status = run_project_cmd(%{bin/rails runner 'puts "hello"'}, "RAILS_ENV" => "test")
      assert status.success?, err
      assert_includes out, "hello"
    end

    def test_verify_is_skipped_in_production_with_default_settings
      out, err, status = run_project_cmd(%{bin/rails runner 'puts "hello"'}, "RAILS_ENV" => "production")
      assert status.success?, err
      assert_equal out, "hello\n"
    end

    def test_assets_precompile
      out, err, status = run_project_cmd(%{bundle exec rake assets:precompile}, "RAILS_ENV" => "production")
      assert status.success?, err
      assets_version = (rails_version > "4.1") ? "4.2+" : rails_version
      assert_dir_included "test/compiled_assets/#{assets_version}", "test/#{rails_version}/public/assets"
    end

    def test_assets_precompile_with_serve_static_files_turned_on
      out, err, status = run_project_cmd(%{bundle exec rake assets:precompile}, "RAILS_ENV" => "production", "RAILS_SERVE_STATIC_FILES" => "true")
      assert status.success?, err
    end

    def rails_version
      Torba::Test::RAILS_VERSION
    end

    def in_project_dir(&blk)
      Dir.chdir("test/#{rails_version}", &blk)
    end

    def run_project_cmd(cmd, env = {})
      default_env = {
        "BUNDLE_GEMFILE" => nil,
        "TORBA_HOME_PATH" => torba_tmp_dir,
        "TORBA_CACHE_PATH" => Test::TmpDir.persistent
      }
      env = default_env.merge(env)

      in_project_dir do
        Open3.capture3(env, cmd)
      end
    end
  end
end
