# frozen_string_literal: true

module Rlt
  module CommandRunner
    def run(arguments)
      command_class = Rlt::CommandsMap.get(arguments[0])
      return print_help if command_class.nil?
      command_class.run(arguments[0], *arguments[1..-1])
    end

    def print_help
      puts 'help!'
    end
  end
end
