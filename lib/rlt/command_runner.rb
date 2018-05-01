# frozen_string_literal: true

module Rlt
  module CommandRunner
    def run(argv)
      command = argv[0]
      arguments = argv[1..-1]
      command_class = Rlt::CommandsMap.get(command)
      return print_help if command_class.nil?
      validate_and_run_command(command, arguments, command_class)
    end

    def print_help
      puts 'help!'
    end

    def validate_and_run_command(command, arguments, command_class)
      valid = command_class.valid_parameters?(command, *arguments)
      return command_class.print_help(command, *arguments) unless valid
      command_class.run(command, *arguments)
    end
  end
end
