Gem::Specification.new do |spec|
  spec.name          = "rake_injector"
  spec.version       = "0.0.1"
  spec.authors       = ["Andrii Malyshko"]
  spec.email         = ["mail@nashbridges.me"]
  spec.description   = "Test gem that modifies Rake namespace thus introducing it"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/torba-rb/torba-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]
end
