module Torba
  module Test
    SUPPORTED_RAILS_VERSIONS = %w[3.2 4.1 4.2 5.0 5.1]
    RAILS_VERSION = ENV["RAILS_VERSION"] || SUPPORTED_RAILS_VERSIONS.last
  end
end
