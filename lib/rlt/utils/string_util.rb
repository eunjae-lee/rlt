# frozen_string_literal: true

module Rlt
  module Utils
    class StringUtil
      def self.underscore(str)
        str.gsub(/::/, '/')
           .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
           .gsub(/([a-z\d])([A-Z])/, '\1_\2')
           .tr('-', '_')
           .downcase
      end

      def self.short_random_string
        (0...4).map { rand(65..90).chr }.join
      end
    end
  end
end
