# frozen_string_literal: true

module Rlt
  class Alias
    def self.unpack(argv)
      config = Rlt.config_map.dig 'alias', argv[0]
      return argv if config.nil?
      config.split(' ') + argv[1..-1]
    end
  end
end