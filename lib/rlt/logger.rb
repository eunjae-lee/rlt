# frozen_string_literal: true

require 'pastel'

module Rlt
  class Logger
    def self.verbose(msg)
      puts Pastel.new.white(msg)
    end

    def self.info(msg)
      puts Pastel.new.cyan(msg)
    end

    def self.warn(msg)
      puts Pastel.new.yellow(msg)
    end

    def self.error(msg)
      puts Pastel.new.red(msg)
    end
  end
end
