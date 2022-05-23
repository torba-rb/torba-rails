Gem::Specification.new do |spec|
  spec.name          = "torba-rails"
  spec.version       = "1.0.3"
  spec.authors       = ["Andrii Malyshko"]
  spec.email         = ["mail@nashbridges.me"]
  spec.description   = "Torba + Rails integration"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/torba-rb/torba-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).grep_v(%r{^test/})
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "torba", "~> 1.0"
  spec.add_dependency "railties", ">= 3.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.4"
  spec.add_development_dependency "assert_dirs_equal", "~> 0.3"
end
