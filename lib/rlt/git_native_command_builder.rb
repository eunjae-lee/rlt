# frozen_string_literal: true

module Rlt
  module Commands
    class GitNativeCommandBuilder
      # rubocop:disable Metrics/MethodLength
      def self.build(command)
        Class.new do
          define_singleton_method :run do |_config, *arguments|
            Shell.new.run! 'git', command, *arguments
          end

          define_singleton_method :print_help do |*_arguments|
            # nothing to do
          end

          define_singleton_method :valid_parameters? do |*_arguments|
            true
          end
        end
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
