require 'fastlane/action'
require_relative '../helper/postmark_helper'
require 'postmark'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Actions
    class PostmarkAction < Action
      def self.run(params)
        @client = ::Postmark::ApiClient.new(params[:api_key])

        UI.message("Sending email via Postmark...")
        begin
          @client.deliver(
            from: params[:from],
            to: params[:to].split(",").map(&:strip),
            subject: params[:subject],
            html_body: params[:message_html],
            text_body: params[:message_text]
          )
        rescue => error
          UI.crash!("Send email via Postmark error: #{error.inspect}")
        end

        UI.success("Email sent successfully!")
      end

      def self.description
        "Send emails via Postmark in fastlane!"
      end

      def self.authors
        ["Levi Bostian"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "Already using Postmark to send emails in your project? Send emails to 1 or more people with ease. Created with the original intent of notifying a group of people of an app release."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_name: "POSTMARK_API_KEY",
                                       description: "Postmark server API ID",
                                       optional: false,
                                       default_value: ENV['POSTMARK_API_KEY']),
          FastlaneCore::ConfigItem.new(key: :from,
                                       env_name: "POSTMARK_FROM_EMAIL_ADDRESS",
                                       description: "Email address to send emails as. This should be an email address from the domain in your Postmark account",
                                       optional: false,
                                       default_value: ENV['POSTMARK_FROM_EMAIL_ADDRESS']),
          FastlaneCore::ConfigItem.new(key: :to,
                                       env_name: "POSTMARK_TO_EMAIL_ADDRESS",
                                       description: "List of email addresses you want to send the email to. Comma separated string is accepted",
                                       optional: false,
                                       default_value: ENV['POSTMARK_TO_EMAIL_ADDRESS']),
          FastlaneCore::ConfigItem.new(key: :subject,
                                       env_name: "POSTMARK_EMAIL_SUBJECT",
                                       description: "The subject you want your email to have",
                                       optional: false,
                                       default_value: ENV['POSTMARK_EMAIL_SUBJECT']),
          FastlaneCore::ConfigItem.new(key: :message_text,
                                       env_name: "POSTMARK_EMAIL_MESSAGE_TEXT",
                                       description: "The body you want your email to have. Text only. If you want to use html instead, leave this option blank",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :message_html,
                                       env_name: "POSTMARK_EMAIL_MESSAGE_HTML",
                                       description: "The body you want your email to have. HTML only. If you want to use text instead, leave this option blank",
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
