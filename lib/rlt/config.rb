# frozen_string_literal: true

require 'yaml'

module Rlt
  module Config
    def config(category, command)
      c = config_map.dig category, command
      return c unless c.nil?
      return {} if command == original_name_of_alias(command)
      config_map.dig(category, original_name_of_alias(command)) || {}
    end

    def original_name_of_alias(command)
      config_map.dig 'alias', command
    end

    def config_keys(category)
      c = config_map.dig(category)
      return [] if c.nil?
      c.keys
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

    def config_map
      (@config_map ||= load_config)
    end
  end

  extend Config
end
