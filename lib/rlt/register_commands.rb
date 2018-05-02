# frozen_string_literal: true

require 'rlt/commands_map'

module Rlt
  class RegisterCommands
    def self.register
      git_native_commands.each do |command|
        CommandsMap.add command, Commands::GitNativeCommandBuilder.build(command)
      end

      CommandsMap.add 'switch', Commands::SwitchCommand
      CommandsMap.add 'cmt', Commands::CmtCommand
    end

    def self.git_native_commands
      %w[add bisect branch checkout clone commit config diff fetch grep init
         log merge mv pull push rebase remote reset rm show status tag]
    end
  end
end
