# frozen_string_literal: true

module Rlt
  class GitNativeCommand
    def self.run(command, arguments)
      puts "command: #{command}"
      puts "arguments: #{arguments}"
    end
  end
end