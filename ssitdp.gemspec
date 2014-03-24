# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssitdp/version'

Gem::Specification.new do |spec|
  spec.name          = 'ssitdp'
  spec.version       = Ssitdp::VERSION
  spec.authors       = ['Cheikh Sidya CAMARA']
  spec.email         = ['scicasoft@gmail.com']
  spec.description   = %q{test de performance}
  spec.summary       = %q{test de performance}
  spec.homepage      = ''

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.executables   = %w[ssitdp]

  spec.add_runtime_dependency 'bundler', '~> 1.3'
  spec.add_runtime_dependency 'rake'
  spec.add_runtime_dependency 'rest_client', '~> 1.7.3'
end
