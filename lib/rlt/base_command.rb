# frozen_string_literal: true

module Rlt
  class BaseCommand
    def self.run(command, config, *arguments)
      raise 'implement me'
    end

    def self.print_help(command, *arguments)
      raise 'implement me'
    end

    def self.valid_parameters?(command, *arguments)
      raise 'implement me'
    end
  end
end
