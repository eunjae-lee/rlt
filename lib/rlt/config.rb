# frozen_string_literal: true

require 'yaml'

module Rlt
  module Config
    def config(commmand)
      (@config ||= load_config)[command] || {}
    end

    def load_config
      YAML.load_file(file_path)
    end

    def file_path
      "#{Dir.pwd}/.rlt.yml"
    end
  end
end