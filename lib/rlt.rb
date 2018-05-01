# frozen_string_literal: true

require 'rlt/version'
require 'rlt/shell'
require 'rlt/logger'
require 'rlt/base_command'
Dir["#{__dir__}/rlt/commands/**/*.rb"].each { |f| require f }
require 'rlt/commands/git_native_command'
require 'rlt/commands_map'
require 'rlt/register_commands'
require 'rlt/command_runner'

module Rlt
  def self.debug
    false
  end
  include RegisterCommands
  extend CommandRunner
end
