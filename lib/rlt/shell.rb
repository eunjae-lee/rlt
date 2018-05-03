# frozen_string_literal: true

require 'etc'
require 'tty-command'

class Shell
  def initialize(opts = {})
    printer = opts[:no_output] ? :null : :quiet
    @cmd = TTY::Command.new(printer: printer, pty: true, dry_run: Rlt.debug)
  end

  def run(*args)
    result = @cmd.run(*args, user: Etc.getlogin)
    puts '' if Rlt.debug
    result
  end

  def run_safely(*args)
    result = @cmd.run!(*args, user: Etc.getlogin)
    puts '' if Rlt.debug
    result
  end
end
