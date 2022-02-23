# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "streambird"
  spec.version       = "1.0.1"
  spec.authors       = ["streambird"]
  spec.email         = ["hello@streambird.io"]

  spec.summary       = %q{Official Ruby Client for Streambird API}
  spec.description   = %q{Streambird is an API For passwordless authentication for web2 and web3. Onboarding users within minutes. This is the official Ruby client.}
  spec.homepage      = "https://streambird.io"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "webmock", "~> 3.5"
  spec.add_development_dependency "vcr", "~> 4.0"

  spec.add_dependency "faraday", "~> 0.11.0"
end
