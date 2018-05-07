# frozen_string_literal: true

require 'erb'
require 'tty-prompt'
require 'tmpdir'

module Rlt
  module Commands
    class Cmt
      CONF_SUBJECT_TEMPLATE = 'subject_template'
      CONF_BODY_TEMPLATE = 'body_template'

      def self.run(config, add_all)
        branch_name = Utils::GitUtil.current_branch_name
        Utils::Logger.info "Committing to '#{branch_name}'"
        (subject, body) = subject_and_body(config, branch_name)
        Utils::GitUtil.add_all if add_all
        commit(subject, body)
      end

      def self.subject_and_body(config, branch_name)
        subject = adjust_subject_template(ask_subject, config, branch_name)
        body = adjust_body_template(ask_body, config, branch_name)
        [subject, body]
      end

      def self.commit(subject, body)
        Utils::GitUtil.commit_with_long_message("#{subject}\n\n#{body}".strip)
      end

      def self.ask_subject
        prompt = TTY::Prompt.new
        prompt.ask('Subject:', active_color: :magenta) do |q|
          q.required true
          q.modify :capitalize
        end.gsub(/\.$/, '')
      end

      def self.ask_body
        puts 'Body: (Insert empty line to finish)'
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

      def self.adjust_subject_template(subject, config, branch_name)
        template = config[CONF_SUBJECT_TEMPLATE]
        return subject if config.nil? || template.nil?
        ERB.new(template).result binding
      end

      def self.adjust_body_template(body, config, branch_name)
        template = config[CONF_BODY_TEMPLATE]
        return body if config.nil? || template.nil?
        ERB.new(template).result binding
      end
    end
  end
end
