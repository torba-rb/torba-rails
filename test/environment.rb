module Torba
  module Test
    SUPPORTED_RAILS_VERSIONS = %w[5.0 5.1] # 3.2, 4.1 and 4.2 do not support Ruby 2.7, but will be still tested on CI
    RAILS_VERSION = ENV["RAILS_VERSION"] || SUPPORTED_RAILS_VERSIONS.last
  end
end
