# frozen_string_literal: true

require 'rlt/git_native_command'

module Rlt
  class Commands
    MAP = {
      'add' => GitNativeCommand,
      'branch' => GitNativeCommand,
      'checkout' => GitNativeCommand,
      'clone' => GitNativeCommand,
      'commit' => GitNativeCommand,
      'config' => GitNativeCommand,
      'diff' => GitNativeCommand,
      'fetch' => GitNativeCommand,
      'grep' => GitNativeCommand,
      'init' => GitNativeCommand,
      'log' => GitNativeCommand,
      'merge' => GitNativeCommand,
      'pull' => GitNativeCommand,
      'push' => GitNativeCommand,
      'remote' => GitNativeCommand,
      'reset' => GitNativeCommand,
      'status' => GitNativeCommand,
      'tag' => GitNativeCommand
    }.freeze

    def self.get(command_name)
      MAP[command_name]
    end
  end
end