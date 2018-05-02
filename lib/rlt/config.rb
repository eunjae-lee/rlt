# frozen_string_literal: true

require 'yaml'

module Rlt
  module Config
    def config(command)
      (@config ||= load_config)['commands'][command]
    rescue NoMethodError
      {}
    end

    def load_config
      YAML.load_file(file_path)
    rescue Errno::ENOENT
      {}
    end

    def file_path
      "#{Dir.pwd}/.rlt.yml"
    end
  end
end