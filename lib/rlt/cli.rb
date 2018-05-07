require 'thor'
require 'rlt/commands/cmt'
require 'rlt/commands/switch'
require 'rlt/commands/close'

module Rlt
  class CLI < Thor
    def self.handle_no_command_error(command)
      raise GitNativeCommandError if Utils::GitUtil::NATIVE_COMMANDS.include? command
      super
    end

    def self.command_name(klass)
      Utils::StringUtil.underscore(klass.name.split('::').last)
    end

    def self.run(klass, *arguments)
      config = Rlt.config('command', command_name(klass))
      klass.send(:run, config, *arguments)
    end

    desc 'cmt', 'Commit with structured commit message'
    method_option :add_all,
                  aliases: '-a',
                  desc: 'Add all before commit',
                  type: :boolean, default: false
    def cmt
      CLI.run Rlt::Commands::Cmt, options.add_all?
    end

    desc 'switch <branch_name>', 'Switch branches with auto stash/unstash'
    def switch(branch_name)
      CLI.run Rlt::Commands::Switch, branch_name
    end

    desc 'close', 'Delete current branch and merge it to master'
    def close
      CLI.run Rlt::Commands::Close
    end
  end
end