
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rlt/version'

Gem::Specification.new do |spec|
  spec.name          = 'rlt'
  spec.version       = Rlt::VERSION
  spec.authors       = ['Paul Lee']
  spec.email         = ['paul@valuepotion.com']

  spec.summary       = 'Better git CLI'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/eunjae-lee/rlt'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
