# frozen_string_literal: true

require 'yaml'

module Rlt
  module Config
    def config(category, command)
      category_config(category)[command] || category_config(category)[original(command)] || {}
    rescue NoMethodError
      {}
    end

    def original(command)
      config('alias', command)
    end

    def config_keys(category)
      category_config(category).keys
    rescue NoMethodError
      []
    end

    def category_config(category)
      (@config ||= load_config)[category]
    end

    def load_config
      YAML.load_file(file_path)
    rescue Errno::ENOENT
      {}
    end

    def file_path
      if Rlt.debug
        "#{Dir.pwd}/.rlt.sample.yml"
      else
        "#{Dir.pwd}/.rlt.yml"
      end
    end
  end
end
