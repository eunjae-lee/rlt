# frozen_string_literal: true

module Rlt
  class CommandsMap
    def self.add(command_name, command_desc, command_class, default_args = [])
      map[command_name] = {
        class: command_class,
        desc: command_desc,
        default_args: default_args
      }
    end

    def self.add_alias(command_name, args)
      dest_command_name = args.first
      default_args = args[1..-1]
      dest_command_class = map[dest_command_name][:class]
      desc = "Alias for \"#{args.join(' ')}\""
      add(command_name, desc, dest_command_class, default_args)
    end

    def self.get(command_name)
      map[command_name]
    end

    def self.desc(command_name)
      get(command_name)[:desc]
    end

    def self.commands
      map.keys
    end

    def self.map
      (@map ||= {})
    end
  end
end
