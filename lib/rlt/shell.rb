# frozen_string_literal: true

require 'etc'
require 'tty-command'

class Shell
  def initialize
    @cmd = TTY::Command.new(printer: :quiet, pty: true, dry_run: Rlt.debug)
  end

  def run(*args)
    @cmd.run(*args, user: Etc.getlogin)
    puts '' if Rlt.debug
  end
end
