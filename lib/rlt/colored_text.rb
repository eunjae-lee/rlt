# frozen_string_literal: true

require 'pastel'

module Rlt
  class ColoredText
    def self.verbose(msg)
      Pastel.new.white(msg)
    end

    def self.info(msg)
      Pastel.new.cyan(msg)
    end

    def self.desc(msg)
      Pastel.new.magenta(msg)
    end

    def self.warn(msg)
      Pastel.new.yellow(msg)
    end

    def self.error(msg)
      Pastel.new.red(msg)
    end
  end
end
