# frozen_string_literal: true

require 'erb'

module Rlt
  module Commands
    class SwitchCommand < BaseCommand
      CONF_BRANCH_NAME_TEMPLATE = 'branch_name_template'.freeze

      def self.run(_command, config, *arguments)
        branch_name = change_branch_name(config, arguments[0])
        switch(branch_name)
        pull
      end

      def self.change_branch_name(config, branch_name)
        branch_name_template = config[CONF_BRANCH_NAME_TEMPLATE]
        return branch_name if branch_name_template.nil?
        ERB.new(branch_name_template).result binding
      end

      def self.switch(branch_name)
        create_and_checkout(branch_name) if checkout(branch_name).failure?
      end

      def self.checkout(branch_name)
        result = shell.run! 'git', 'checkout', branch_name
        Logger.info "Switched to '#{branch_name}'." unless result.failure?
        result
      end

      def self.create_and_checkout(branch_name)
        shell.run 'git', 'checkout', '-b', branch_name
        Logger.info "Created & Switched to '#{branch_name}'."
      end

      def self.pull
        # Ignore error when there's no remote repository specified.
        result = shell.run! 'git', 'pull'
        Logger.info 'Pulled from remote.' unless result.failure?
        result
      end

      def self.print_help(command, *arguments)
        puts "help #{command} #{arguments}"
      end

      def self.valid_parameters?(_command, *arguments)
        arguments.size == 1
      end

      def self.shell
        Shell.new(:null)
      end
    end
  end
end
