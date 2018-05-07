# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rlt/utils/shell'
require 'rlt/debug'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :dev do
  Rlt::Utils::Shell.new.run *%w[gem uninstall rlt -x]
  gem_path = `rake build`.strip.split('built to ')[1].gsub(/\.$/, '')
  Rlt::Utils::Shell.new.run 'gem', 'install', '--local', gem_path
end