# frozen_string_literal: true

module Rlt
  module Commands
    class GitNativeCommand < BaseCommand
      def self.run(command, *arguments)
        Shell.new.run! 'git', command, *arguments
      end

      def self.print_help(command, *arguments)
        # nothing to do
      end

      def self.valid_parameters?(_command, *_arguments)
        true
      end
    end
  end
end
