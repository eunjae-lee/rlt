# frozen_string_literal: true

module Rlt
  module Commands
    class Close
      def self.run(config)
        default_branch = default_branch(config)
        current_branch_name = Utils::GitUtil.current_branch_name
        return if should_stop?(default_branch)
        run_internal(current_branch_name, default_branch)
        Utils::Logger.info "Done closing `#{current_branch_name}`."
      end

      def self.run_internal(current_branch_name, default_branch)
        merge_back_and_forth(current_branch_name, default_branch)
        delete_branch(current_branch_name)
      end

      def self.should_stop?(default_branch)
        return true if uncommitted_changes?
        return true if default_branch_now?(default_branch)
      end

      def self.uncommitted_changes?
        result = Utils::GitUtil.uncommitted_change?
        print_uncommitted_changes_error if result
        result
      end

      def self.default_branch_now?(default_branch)
        result = Utils::GitUtil.current_branch_name == default_branch
        print_default_branch_now_error(default_branch) if result
        result
      end

      def self.default_branch(config)
        config['default_branch'] || 'master'
      end

      def self.merge_back_and_forth(current_branch_name, default_branch)
        Utils::GitUtil.merge_from(default_branch, print_info: true)
        return if any_conflict?
        Utils::GitUtil.checkout(default_branch, print_info: true)
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

      def self.print_default_branch_now_error(default_branch)
        Utils::Logger.error "You cannot close `#{default_branch}`."
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
