# frozen_string_literal: true

require 'erb'

module Rlt
  module Commands
    class SwitchCommand < BaseCommand
      CONF_BRANCH_NAME_TEMPLATE = 'branch_name_template'.freeze

      def self.run(config, *arguments)
        branch_name = change_branch_name(config, arguments[0])
        switch(branch_name)
      end

      def self.change_branch_name(config, branch_name)
        return branch_name if exclude?(config, branch_name)
        branch_name_template = config[CONF_BRANCH_NAME_TEMPLATE]
        return branch_name if branch_name_template.nil?
        ERB.new(branch_name_template).result binding
      end

      def self.exclude?(config, branch_name)
        list = %w[master develop] + (config['exclude'] || [])
        list.include? branch_name
      end

      def self.switch(branch_name)
        create_and_checkout(branch_name) if checkout(branch_name).failure?
      end

      def self.checkout(branch_name)
        result = shell.run_safely 'git', 'checkout', branch_name
        Logger.info "Switched to '#{branch_name}'." unless result.failure?
        result
      end

      def self.create_and_checkout(branch_name)
        shell.run 'git', 'checkout', '-b', branch_name
        Logger.info "Created & Switched to '#{branch_name}'."
      end

      def self.print_help(*_arguments)
        puts 'USAGE:'
        puts '  rlt switch <branch_name>'
        puts ''
        puts '  This command switches to <branch_name>. It creates the branch if it does not exist.'
      end

      def self.valid_parameters?(*arguments)
        arguments.size == 1
      end

      def self.shell
        Shell.new(no_output: true)
      end
    end
  end
end
