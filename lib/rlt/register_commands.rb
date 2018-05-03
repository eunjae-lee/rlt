# frozen_string_literal: true

require 'rlt/commands_map'

module Rlt
  class RegisterCommands
    # rubocop:disable Metrics/MethodLength
    def self.register
      git_native_commands.each do |command|
        desc = 'Git native command'
        klass = Commands::GitNativeCommandBuilder.build(command)
        CommandsMap.add command, desc, klass
      end

      CommandsMap.add 'switch', 'Switch to branch', Commands::SwitchCommand
      CommandsMap.add 'cmt', 'Commit in clear way', Commands::CmtCommand
    end
    # rubocop:enable Metrics/MethodLength

    def self.git_native_commands
      %w[add archive bisect branch checkout clone commit config diff fetch grep init
         log merge mv pull push rebase remote reset rm show status tag]
    end
  end
end
