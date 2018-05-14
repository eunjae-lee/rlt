
module Rlt
  module Commands
    class Rst
      def self.run(_config)
        Utils::GitUtil.reset_hard_head
        Utils::GitUtil.clean_untracked
      end
    end
  end
end
