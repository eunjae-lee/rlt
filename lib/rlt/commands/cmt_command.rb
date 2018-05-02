# frozen_string_literal: true

require 'erb'
require 'pastel'
require 'tty-prompt'
require 'tmpdir'

module Rlt
  module Commands
    class CmtCommand < BaseCommand
      CONF_SUBJECT_TEMPLATE = 'subject_template'.freeze
      CONF_BODY_TEMPLATE = 'body_template'.freeze

      def self.run(_command, config, *arguments)
        branch_name = acquire_branch_name
        subject = change_subject(ask_subject, config, branch_name)
        body = change_body(ask_body, config, branch_name)
        add_all if arguments[0] == '-a'
        commit(subject, body)
      end

      def self.add_all
        Shell.new.run 'git', 'add', '.'
      end

      def self.commit(subject, body)
        commit_msg_file_path = "#{Dir.tmpdir}/.rlt.commit.msg.#{short_random_string}"
        File.write(commit_msg_file_path, "#{subject}\n\n#{body}")
        Shell.new.run 'git', 'commit', '-F', commit_msg_file_path
        File.delete(commit_msg_file_path)
      end

      def self.short_random_string
        (0...4).map { rand(65..90).chr }.join
      end

      def self.ask_subject
        prompt = TTY::Prompt.new
        prompt.ask('Subject:', active_color: :cyan) do |q|
          q.required true
          q.modify :capitalize
        end
      end

      def self.ask_body
        puts 'Body: ' + Pastel.new.magenta('(Insert empty line to finish)')
        lines = ask_multiline_until_done('>', :magenta)
        lines.join("\n")
      end

      # rubocop:disable Metrics/MethodLength
      def self.ask_multiline_until_done(message, active_color)
        lines = []
        loop do
          line = TTY::Prompt.new.ask(message, active_color: active_color)
          break if line.nil?
          lines << line
        end
        lines
      end
      # rubocop:enable Metrics/MethodLength

      def self.change_subject(subject, config, branch_name)
        template = config[CONF_SUBJECT_TEMPLATE]
        return subject if config.nil? || template.nil?
        ERB.new(template).result binding
      end

      def self.change_body(body, config, branch_name)
        template = config[CONF_BODY_TEMPLATE]
        return body if config.nil? || template.nil?
        ERB.new(template).result binding
      end

      def self.acquire_branch_name
        `git rev-parse --abbrev-ref HEAD`.strip
      end

      def self.print_help(command, *arguments)
        puts "help #{command} #{arguments}"
      end

      def self.valid_parameters?(_command, *arguments)
        arguments.size <= 1
      end
    end
  end
end
