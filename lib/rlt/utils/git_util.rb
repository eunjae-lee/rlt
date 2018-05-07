module Rlt
  module Utils
    class GitUtil
      def self.current_branch_name
        `git rev-parse --abbrev-ref HEAD`.strip
      end

      def self.add_all
        Shell.new.run 'git', 'add', '-A'
      end

      def self.uncommitted_change?
        !`git status -s`.strip.empty?
      end

      def self.latest_stash_name(branch_name)
        line = `git stash list`.strip.split("\n").find do |line|
          line.split(':')[1].strip == "On #{branch_name}"
        end
        return nil if line.nil?
        line.split(':').first
      end

      def self.save_stash(message)
        Shell.new.run 'git', 'stash', 'save', '--include-untracked', message
      end

      def self.apply_stash(name)
        Shell.new.run 'git', 'stash', 'apply', name, '--index'
      end

      def self.drop_stash(name)
        Shell.new.run 'git', 'stash', 'drop', name
      end

      def self.checkout(branch_name)
        Shell.new.run 'git', 'checkout', branch_name
      end

      def self.silently_try_checkout(branch_name)
        result = Shell.new(no_output: true).run_safely 'git', 'checkout', branch_name
        result.success?
      end

      def self.silently_create_and_checkout(branch_name)
        Shell.new(no_output: true).run 'git', 'checkout', '-b', branch_name
      end

      def self.commit_with_long_message(message)
        Logger.verbose message if Rlt.debug
        commit_msg_file_path = "#{Dir.tmpdir}/.rlt.commit.msg.#{StringUtil.short_random_string}"
        File.write(commit_msg_file_path, message)
        Shell.new.run 'git', 'commit', '-F', commit_msg_file_path
        File.delete(commit_msg_file_path)
      end

      def self.merge_from(branch_name)
        Shell.new.run 'git', 'merge', branch_name
      end

      def self.any_conflict?
        !`git diff --name-only --diff-filter=U`.strip.empty?
      end

      def self.delete_branch(branch_name)
        Shell.new.run 'git', 'branch', '-d', branch_name
      end

      def self.remotes
        `git remote`.strip.split('\n')
      end

      def self.safely_delete_remote_branch(remote, branch_name)
        Shell.new.run_safely 'git', 'push', remote, ":#{branch_name}"
      end
    end
  end
end