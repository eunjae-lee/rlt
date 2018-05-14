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

    def load_config(path)
      result = YAML.load_file(path)
      return result if result.is_a? Hash
      {}
    rescue Errno::ENOENT
      {}
    end

    def local_config_path
      sample_config_path = "#{Dir.pwd}/.rlt.sample.yml"
      return sample_config_path if Rlt.debug && File.exist?(sample_config_path)
      "#{Dir.pwd}/.rlt.yml"
    end

    def global_config_path
      File.expand_path('~/.rlt.yml')
    end

    def load_all_configs
      load_config(global_config_path).merge(load_config(local_config_path))
    end

    def config_map
      (@config_map ||= load_all_configs)
    end
  end

  extend Config
end
