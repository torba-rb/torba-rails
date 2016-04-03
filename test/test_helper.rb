require "bundler/setup"
require "minitest/autorun"
require "minitest/assert_dirs_equal"
require "tmpdir"
require "fileutils"

module Torba
  module Test
    module TmpDir
      attr_reader :torba_tmp_dir

      def self.persistent
        @persistent ||= File.realpath(Dir.mktmpdir("torba"))
      end

      def before_setup
        @torba_tmp_dir = File.realpath(Dir.mktmpdir("torba"))
        super
      end

      def after_teardown
        FileUtils.rm_rf(torba_tmp_dir)
        super
      end

      Minitest.after_run do
        FileUtils.rm_rf(persistent)
      end
    end
  end
end

class Minitest::Test
  include Torba::Test::TmpDir
end
