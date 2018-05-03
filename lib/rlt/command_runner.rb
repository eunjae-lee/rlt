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
      puts 'Available commands:'
      Rlt::CommandsMap.commands.each do |command|
        desc = Rlt::CommandsMap.desc(command)
        puts "  #{command}#{spaces(command)}    #{desc}"
      end
    end

    def spaces(command)
      size = max_command_length - command.size
      ' ' * size
    end

    def max_command_length
      @max_command_length ||= Rlt::CommandsMap.commands.map(&:size).max
    end

    def validate_and_run_command(command, arguments, command_class)
      valid = command_class.valid_parameters?(*arguments)
      return command_class.print_help(*arguments) unless valid
      config = Rlt.config('command', command)
      command_class.run(config, *arguments)
    end
  end
end
