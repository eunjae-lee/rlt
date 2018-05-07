# frozen_string_literal: true

require 'pastel'

module Rlt
  module Utils
    class ColoredText
      def self.verbose(msg)
        Pastel.new.white(msg)
      end

      def self.info(msg)
        Pastel.new.decorate(msg, :cyan, :bold)
      end

      def self.desc(msg)
        Pastel.new.green(msg)
      end

      def self.warn(msg)
        Pastel.new.yellow(msg)
      end

      def self.error(msg)
        Pastel.new.red(msg)
      end
    end
  end
end
