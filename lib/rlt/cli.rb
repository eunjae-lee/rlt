require 'thor'
require 'rlt/commands/cmt'
require 'rlt/commands/switch'

module Rlt
  class CLI < Thor
    def self.command_name(klass)
      Utils::StringUtil.underscore(klass.name.split('::').last)
    end

    def self.run(klass, *arguments)
      config = Rlt.config('command', command_name(klass))
      klass.send(:run, config, *arguments)
    end

    desc 'cmt', 'Commit in clear way'
    method_option :add_all,
                  aliases: '-a',
                  desc: 'Add all before commit',
                  type: :boolean, default: false
    def cmt
      CLI.run Rlt::Commands::Cmt, options.add_all?
    end

    desc 'switch <branch_name>', 'Switch to branch'
    def switch(branch_name)
      CLI.run Rlt::Commands::Switch, branch_name
    end
  end
end