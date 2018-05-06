# frozen_string_literal: true

module Rlt
  module Commands
    class CloseCommand < BaseCommand
      def self.run(config, *_arguments)
        return unless check_uncommitted_changes
        merge_back_and_forth(master_branch(config))
      end

      def self.check_uncommitted_changes
        return true if `git status -s`.strip.empty?
        Logger.error 'There are uncommitted changes.'
        Logger.error 'Commit them first!'
        false
      end

      def self.master_branch(config)
        config['master_branch'] || 'master'
      end

      def self.merge_back_and_forth(master_branch)
        Shell.new.run 'git', 'merge', master_branch
        unless `git diff --name-only --diff-filter=U`.strip.empty?
          # then it's conflict!
        end
      end

      # rubocop:disable Metrics/MethodLength
      def self.print_help(*_arguments)
        puts 'USAGE:'
        puts '  rlt close'
        puts ''
        puts '  This command'
        puts '    1. Merges master to this branch'
        puts '    2. Merges back to master'
        puts '    3. Switches to master'
        puts '    4. Deletes this branch'
      end
      # rubocop:enable Metrics/MethodLength

      def self.valid_parameters?(*arguments)
        arguments.empty?
      end
    end
  end
end
