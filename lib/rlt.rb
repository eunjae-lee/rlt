# frozen_string_literal: true

require 'rlt/version'
require 'rlt/shell'
require 'rlt/commands'

module Rlt
  def self.run(arguments)
    command_class = Rlt::Commands.get(arguments[0])
    return print_help if command_class.nil?
    command_class.run(arguments[0], *arguments[1..-1])
  end

  def self.print_help
    puts 'help!'
  end
end
