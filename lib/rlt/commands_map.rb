# frozen_string_literal: true

module Rlt
  class CommandsMap
    def self.add(command_name, command_class)
      (@map ||= {})[command_name] = command_class
    end

    def self.get(command_name)
      (@map ||= {})[command_name]
    end
  end
end
