# frozen_string_literal: true

module Rlt
  class BaseCommand
    def self.run(config, *arguments)
      raise 'implement me'
    end

    def self.print_help(*arguments)
      raise 'implement me'
    end

    def self.valid_parameters?(*arguments)
      raise 'implement me'
    end
  end
end
