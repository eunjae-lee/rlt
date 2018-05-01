# frozen_string_literal: true

require 'rlt/version'
require 'rlt/shell'
require 'rlt/commands/git_native_command'
require 'rlt/commands_map'
require 'rlt/register_commands'
require 'rlt/command_runner'

module Rlt
  def self.debug
    true
  end
  include RegisterCommands
  extend CommandRunner
end
