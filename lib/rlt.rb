# frozen_string_literal: true

require 'rlt/version'
require 'rlt/config'
require 'rlt/utils/shell'
require 'rlt/utils/colored_text'
require 'rlt/utils/logger'
require 'rlt/utils/string_util'
require 'rlt/utils/git_util'
require 'rlt/commands/base'
require 'rlt/cli'

module Rlt
  def self.debug
    ENV['RLT_DEBUG']
  end
end
