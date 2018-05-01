# frozen_string_literal: true

module Rlt
  module Commands
    class GitNativeCommand
      def self.run(command, *arguments)
        Shell.new.run 'git', command, *arguments
      end
    end
  end
end
