# frozen_string_literal: true

module Rlt
  module Commands
    class Close
      def self.run(config)
        master_branch = master_branch(config)
        current_branch_name = Utils::GitUtil.current_branch_name
        return if should_stop?(master_branch, config)
        run_internal(current_branch_name, master_branch)
        Utils::Logger.info "Done closing `#{current_branch_name}`."
      end

      def self.run_internal(current_branch_name, master_branch)
        merge_back_and_forth(current_branch_name, master_branch)
        delete_branch(current_branch_name)
      end

      def self.should_stop?(master_branch, config)
        return true if uncommitted_changes?
        return true if config_not_existing?(config)
        return true if master_branch_now?(master_branch)
      end

      def self.uncommitted_changes?
        result = Utils::GitUtil.uncommitted_change?
        print_uncommitted_changes_error if result
        result
      end

      def self.config_not_existing?(config)
        result = config['master_branch'].nil?
        print_explicit_config_error if result
        result
      end

      def self.master_branch_now?(master_branch)
        result = Utils::GitUtil.current_branch_name == master_branch
        print_master_branch_now_error(master_branch) if result
        result
      end

      def self.master_branch(config)
        config['master_branch']
      end

      def self.merge_back_and_forth(current_branch_name, master_branch)
        Utils::GitUtil.merge_from(master_branch, print_info: true)
        return if any_conflict?
        Utils::GitUtil.checkout(master_branch, print_info: true)
        Utils::GitUtil.merge_from(current_branch_name, print_info: true)
      end

      def self.any_conflict?
        result = Utils::GitUtil.any_conflict?
        print_conflict_error if result
        result
      end

      def self.print_uncommitted_changes_error
        Utils::Logger.error 'There are uncommitted changes.'
        Utils::Logger.error 'Commit them first!'
      end

      # rubocop:disable Metrics/MethodLength
      def self.print_explicit_config_error
        Utils::Logger.error 'You must explicitly configure name of master branch at `.rlt.yml`'
        Utils::Logger.error 'For example,'
        Utils::Logger.error ''
        Utils::Logger.error '# .rlt.yml'
        Utils::Logger.error 'command:'
        Utils::Logger.error '  close:'
        Utils::Logger.error '    master_branch: master'
      end
      # rubocop:enable Metrics/MethodLength

      def self.print_master_branch_now_error(master_branch)
        Utils::Logger.error "You cannot close `#{master_branch}`."
      end

      def self.print_conflict_error
        Utils::Logger.error 'Aborting the process due to the conflict.'
        Utils::Logger.error 'Resolve them first, and try it again.'
      end

      def self.delete_branch(current_branch_name)
        Utils::GitUtil.delete_branch(current_branch_name, print_info: true)
        Utils::GitUtil.remotes.each do |remote|
          Utils::GitUtil.safely_delete_remote_branch(remote, current_branch_name, print_info: true)
        end
      end
    end
  end
end
