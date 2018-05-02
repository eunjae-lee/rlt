# frozen_string_literal: true

require 'rlt/version'
require 'rlt/shell'
require 'rlt/logger'
require 'rlt/base_command'
require 'rlt/git_native_command_builder'
Dir["#{__dir__}/rlt/commands/**/*.rb"].each { |f| require f }
require 'rlt/register_commands'
require 'rlt/register_aliases'
require 'rlt/command_runner'
require 'rlt/config'

module Rlt
  def self.debug
    ENV['RLT_DEBUG']
  end
  extend Config
  extend CommandRunner

  RegisterCommands.register
  RegisterAliases.register
end
