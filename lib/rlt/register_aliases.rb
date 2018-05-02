# frozen_string_literal: true

require 'rlt/commands_map'

module Rlt
  class RegisterAliases
    def self.register
      Rlt.config_keys('alias').each do |command|
        args = Rlt.config('alias', command).split(' ')
        CommandsMap.add_alias(command, args)
      end
    end
  end
end
