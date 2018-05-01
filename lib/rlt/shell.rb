# frozen_string_literal: true

require 'etc'
require 'tty-command'

class Shell
  def initialize
    @cmd = TTY::Command.new(printer: :quiet, pty: true)
  end

  def run(*args)
    @cmd.run *args, user: Etc.getlogin
  end
end
