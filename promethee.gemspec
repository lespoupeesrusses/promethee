# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "promethee/version"

Gem::Specification.new do |spec|
  spec.name          = "promethee"
  spec.version       = Promethee::VERSION
  spec.authors       = ["Julien Dargelos", "Arnaud Levy", "Pierre-André Boissinot", "Antoine Prévost"]
  spec.email         = ["contact@juliendargelos.com", "alevy@lespoupees.paris", "paboissinot@lespoupees.paris", "aprevost@lespoupees.paris"]

  spec.summary       = "Bring fire to your page"
  spec.homepage      = "https://github.com/lespoupeesrusses/promethee"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
