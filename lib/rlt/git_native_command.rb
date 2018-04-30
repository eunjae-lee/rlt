# frozen_string_literal: true

module Rlt
  class GitNativeCommand
    def self.run(command, arguments)
      cmd = TTY::Command.new(color: true, printer: :quiet)
      cmd.run 'git', command, *arguments
    end
  end
end