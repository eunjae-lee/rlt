# frozen_string_literal: true

require 'tty-command'

module Rlt
  module Utils
    class Shell
      def initialize(opts = {})
        @cmd = TTY::Command.new(printer: printer(opts), pty: true, dry_run: Rlt.debug)
      end

      def run(*args)
        result = @cmd.run(*args, user: current_user)
        puts '' if Rlt.debug
        result
      end

      def run_safely(*args)
        result = @cmd.run!(*args, user: current_user)
        puts '' if Rlt.debug
        result
      end

      def current_user
        ENV['USER'] || ENV['USERNAME']
      end

      private

      def printer(opts)
        if Rlt.debug
          :quiet
        else
          opts[:no_output] ? :null : :quiet
        end
      end
    end
  end
end
