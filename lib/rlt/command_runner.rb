# frozen_string_literal: true

module Rlt
  module CommandRunner
    def run(argv)
      command = argv[0]
      arguments = argv[1..-1]
      info = Rlt::CommandsMap.get(command)
      return print_help if info.nil? || info[:class].nil?
      validate_and_run_command(command, info[:default_args] + arguments, info[:class])
    end

    def print_help
      puts 'help!'
    end

    def validate_and_run_command(command, arguments, command_class)
      valid = command_class.valid_parameters?(*arguments)
      return command_class.print_help(*arguments) unless valid
      config = Rlt.config('command', command)
      command_class.run(config, *arguments)
    end
  end
end
