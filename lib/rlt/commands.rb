# frozen_string_literal: true

require 'rlt/git_native_command'

module Rlt
  class Commands
    def self.get(command_name)
      item = list.select {|item| item[0] == command_name}.first
      return nil if item.nil?
      item[1]
    end

    def self.list
      [
        ['add', GitNativeCommand]
      ]
    end
  end
end