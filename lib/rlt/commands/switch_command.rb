# frozen_string_literal: true

module Rlt
  module Commands
    class SwitchCommand
      def self.run(command, *arguments)
        return print_help(command, *arguments) unless valid_parameter?(arguments)
        save_stash
        switch
        pop_stash
      end

      def self.print_help(command, *arguments)
        puts "help #{command} #{arguments}"
      end

      def self.save_stash
        Shell.new.run 'git', 'stash', 'save', '--include-untracked', 'Auto stash'
      end

      def self.valid_parameter?(arguments)
        arguments.size == 1
      end
    end
  end
end
