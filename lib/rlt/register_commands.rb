# frozen_string_literal: true

module Rlt
  module RegisterCommands
    CommandsMap.add 'add', Commands::GitNativeCommand
    CommandsMap.add 'branch', Commands::GitNativeCommand
    CommandsMap.add 'checkout', Commands::GitNativeCommand
    CommandsMap.add 'clone', Commands::GitNativeCommand
    CommandsMap.add 'commit', Commands::GitNativeCommand
    CommandsMap.add 'config', Commands::GitNativeCommand
    CommandsMap.add 'diff', Commands::GitNativeCommand
    CommandsMap.add 'fetch', Commands::GitNativeCommand
    CommandsMap.add 'grep', Commands::GitNativeCommand
    CommandsMap.add 'init', Commands::GitNativeCommand
    CommandsMap.add 'log', Commands::GitNativeCommand
    CommandsMap.add 'merge', Commands::GitNativeCommand
    CommandsMap.add 'pull', Commands::GitNativeCommand
    CommandsMap.add 'push', Commands::GitNativeCommand
    CommandsMap.add 'remote', Commands::GitNativeCommand
    CommandsMap.add 'reset', Commands::GitNativeCommand
    CommandsMap.add 'status', Commands::GitNativeCommand
    CommandsMap.add 'tag', Commands::GitNativeCommand

    CommandsMap.add 'switch', Commands::SwitchCommand
  end
end
