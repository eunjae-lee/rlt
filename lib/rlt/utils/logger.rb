# frozen_string_literal: true

require 'pastel'

module Rlt
  module Utils
    class Logger
      def self.verbose(msg)
        puts ColoredText.verbose(msg)
      end

      def self.info(msg)
        puts ColoredText.info(msg)
      end

      def self.desc(msg)
        puts ColoredText.desc(msg)
      end

      def self.warn(msg)
        puts ColoredText.warn(msg)
      end

      def self.error(msg)
        puts ColoredText.error(msg)
      end
    end
  end
end
