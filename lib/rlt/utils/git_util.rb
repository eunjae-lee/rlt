# frozen_string_literal: true

module Rlt
  module Utils
    class GitUtil
      # git help -a
      NATIVE_COMMANDS =
        %w[add add--interactive am annotate apply archimport archive bisectbisect--helper blame
           branch bundle cat-file check-attr check-ignore check-mailmap check-ref-format checkout
           checkout-index cherry cherry-pick citool clean clone column commit commit-tree config
           count-objects credential credential-cache credential-cache--daemon credential-store
           cvsexportcommit cvsimport cvsserver daemon describe diff diff-files diff-index diff-tree
           difftool difftool--helper fast-export fast-import fetch fetch-pack filter-branch
           fmt-merge-msg for-each-ref format-patch fsck fsck-objects gc get-tar-commit-id grep gui
           gui--askpass hash-object help http-backend http-fetch http-push index-pack init init-db
           instaweb interpret-trailers log ls-files ls-remote ls-tree mailinfo mailsplit merge
           merge-base merge-file merge-index merge-octopus merge-one-file merge-ours merge-recursive
           merge-resolve merge-subtree merge-tree mergetool mktag mktree mv name-rev notes p4
           pack-objects pack-redundant pack-refs patch-id prune prune-packed pull push quiltimport
           read-tree rebase receive-pack reflog relink remote remote-ext remote-fd remote-ftp
           remote-ftps remote-http remote-https remote-testsvn repack replace request-pull rerere
           reset rev-list rev-parse revert rm send-email send-pack sh-i18n--envsubst shell shortlog
           show show-branch show-index show-ref stage stash status stripspace submodule
           submodule--helper svn symbolic-ref tag unpack-file unpack-objects update-index update-ref
           update-server-info upload-archive upload-pack var verify-commit verify-pack verify-tag
           web--browse whatchanged worktree write-tree].freeze

      def self.execute_native_command(args)
        Shell.new.run 'git', *args
      end

      def self.current_branch_name
        `git rev-parse --abbrev-ref HEAD`.strip
      end

      def self.add_all
        Shell.new.run 'git add -A'
      end

      def self.uncommitted_change?
        !`git status -s`.strip.empty?
      end

      def self.latest_stash_name(branch_name)
        line = `git stash list`.strip.split("\n").find do |l|
          l.split(':')[1].strip == "On #{branch_name}"
        end
        return nil if line.nil?
        line.split(':').first
      end

      def self.save_stash(message, opts = {})
        Logger.info 'Saving stash' if opts[:print_info]
        Shell.new.run 'git stash save', '--include-untracked', message
      end

      def self.apply_stash(name, opts = {})
        Logger.info 'Applied stash' if opts[:print_info]
        Shell.new.run 'git stash apply', name, '--index'
      end

      def self.drop_stash(name, opts = {})
        Logger.info 'Dropped stash' if opts[:print_info]
        Shell.new.run 'git stash drop', name
      end

      def self.checkout(branch_name, opts = {})
        Logger.info "Switching to `#{branch_name}`" if opts[:print_info]
        Shell.new.run 'git checkout', branch_name
      end

      def self.silently_try_checkout(branch_name)
        Shell.new(no_output: true).run_safely 'git checkout', branch_name
      end

      def self.silently_create_and_checkout(branch_name)
        Shell.new(no_output: true).run 'git checkout -b', branch_name
      end

      def self.commit_with_long_message(message)
        Logger.verbose message if Rlt.debug
        commit_msg_file_path = "#{Dir.tmpdir}/.rlt.commit.msg.#{StringUtil.short_random_string}"
        File.write(commit_msg_file_path, message)
        Shell.new.run 'git commit -F', commit_msg_file_path
        File.delete(commit_msg_file_path)
      end

      def self.merge_from(branch_name, opts = {})
        Logger.info "Merging from `#{branch_name}`" if opts[:print_info]
        Shell.new.run 'git merge', branch_name
      end

      def self.any_conflict?
        !`git diff --name-only --diff-filter=U`.strip.empty?
      end

      def self.delete_branch(branch_name, opts = {})
        Logger.info "Deleting `#{branch_name}`" if opts[:print_info]
        Shell.new.run 'git branch -d', branch_name
      end

      def self.remotes
        `git remote`.strip.split('\n')
      end

      def self.safely_delete_remote_branch(remote, branch_name, opts = {})
        Logger.info "Try deleting remote branch: #{remote}/#{branch_name}" if opts[:print_info]
        Shell.new.run_safely 'git push', remote, ":#{branch_name}"
      end

      def self.reset_hard_head
        Shell.new.run 'git reset --hard HEAD'
      end

      def self.clean_untracked
        Shell.new.run 'git clean -fd'
      end
    end
  end
end
