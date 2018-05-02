# frozen_string_literal: true

module Rlt
  class CommandsMap
    def self.add(command_name, command_class, default_args = [])
      map[command_name] = {
        class: command_class,
        default_args: default_args
      }
    end

    def self.add_alias(command_name, args)
      dest_command_name = args.first
      default_args = args[1..-1]
      dest_command_class = map[dest_command_name][:class]
      add(command_name, dest_command_class, default_args)
    end

    def self.get(command_name)
      map[command_name]
    end

    def self.map
      (@map ||= {})
    end
  end
end
