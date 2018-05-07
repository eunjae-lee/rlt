
# frozen_string_literal: true

$LOAD_PATH << File.expand_path('lib', __dir__)
require 'rlt/version'

Gem::Specification.new do |spec|
  spec.name          = 'rlt'
  spec.version       = Rlt::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Eunjae Lee']
  spec.email         = ['karis612@gmail.com']

  spec.summary       = 'Start using Git on command line again with `rlt`'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/eunjae-lee/rlt'
  spec.license       = 'MIT'
  spec.metadata = {
    'source_code_uri' => 'https://github.com/eunjae-lee/rlt',
    'changelog_uri' => 'https://github.com/eunjae-lee/rlt/blob/master/CHANGES.md',
    'bug_tracker_uri' => 'https://github.com/eunjae-lee/rlt/issues'
  }

  spec.files = Dir['lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = ['rlt']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_dependency 'pastel', '~> 0.7.2'
  spec.add_dependency 'tty-command', '~> 0.8.0'
  spec.add_dependency 'tty-prompt', '~> 0.16.1'
  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
