# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$:.unshift(lib) unless $:.include?(lib)
require "github_url/version"

Gem::Specification.new do |spec|
  spec.name          = "github_url"
  spec.version       = GithubUrl::VERSION
  spec.authors       = ["dizehacioglu"]
  spec.email         = ["dh1272@nyu.edu"]

  spec.summary       = %q(A small ruby gem for parsing Github URLs)
  spec.homepage      = "https://github.com/GalvanizeOpenSource/github_url"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "rubocop"
end
