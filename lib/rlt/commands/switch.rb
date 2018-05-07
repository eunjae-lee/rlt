# frozen_string_literal: true

require 'erb'

module Rlt
  module Commands
    class Switch
      CONF_BRANCH_NAME_TEMPLATE = 'branch_name_template'

      def self.run(config, branch_name)
        modified_branch_name = change_branch_name(config, branch_name)
        save_stash_if_any
        switch(modified_branch_name)
        apply_stash_if_any(modified_branch_name)
      end

      def self.change_branch_name(config, branch_name)
        return branch_name if dont_change_branch_name?(config, branch_name)
        branch_name_template = config[CONF_BRANCH_NAME_TEMPLATE]
        return branch_name if branch_name_template.nil?
        ERB.new(branch_name_template).result binding
      end

      def self.save_stash_if_any
        return if Utils::GitUtil.uncommitted_change?
        Utils::GitUtil.save_stash('Auto stash', print_info: true)
      end

      def self.apply_stash_if_any(branch_name)
        stash_name = Utils::GitUtil.latest_stash_name(branch_name)
        return if stash_name.nil?
        Utils::GitUtil.apply_stash(stash_name, print_info: true)
        Utils::GitUtil.drop_stash(stash_name, print_info: true)
      end

      def self.dont_change_branch_name?(config, branch_name)
        list = %w[master develop] + (config['exclude'] || [])
        list.include? branch_name
      end

      def self.switch(branch_name)
        create_and_checkout(branch_name) unless checkout(branch_name)
      end

      def self.checkout(branch_name)
        result = Utils::GitUtil.silently_try_checkout(branch_name)
        Utils::Logger.info "Switched to '#{branch_name}'." if result
        result
      end

      def self.create_and_checkout(branch_name)
        Utils::GitUtil.silently_create_and_checkout(branch_name)
        Utils::Logger.info "Created & Switched to '#{branch_name}'."
      end
    end
  end
end
