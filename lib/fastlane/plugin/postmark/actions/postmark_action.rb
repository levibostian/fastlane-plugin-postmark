require 'fastlane/action'
require_relative '../helper/postmark_helper'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Actions
    class PostmarkAction < Action
      def self.run(params)
        access_key = params[:access_key]
        secret_access_key = params[:secret_access_key]
        region = params[:region]

        topic_arn = params[:topic_arn]
        message = params[:message]
        subject = params[:subject]

        Helper::AwsSnsTopicHelper.verify_params(params, [:access_key, :secret_access_key, :region, :topic_arn, :message, :subject])

        topic_sender = Helper::AwsSns.new(access_key, secret_access_key, region, topic_arn)

        UI.message("Sending message to SNS topic...")
        topic_sender.publish_message(message, subject)
        UI.success("AWS SNS Topic message sent!")
      end

      def self.description
        ""
      end

      def self.authors
        ["Levi Bostian"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        "Public a new message to an AWS SNS topic. Created with the original intent of notifying a SNS topic about a new app release."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :access_key,
                                       env_name: "AWS_SNS_ACCESS_KEY",
                                       description: "AWS Access Key ID",
                                       optional: false,
                                       default_value: ENV['AWS_ACCESS_KEY_ID']),
          FastlaneCore::ConfigItem.new(key: :secret_access_key,
                                       env_name: "AWS_SNS_SECRET_ACCESS_KEY",
                                       description: "AWS Secret Access Key",
                                       optional: false,
                                       default_value: ENV['AWS_SECRET_ACCESS_KEY']),
          FastlaneCore::ConfigItem.new(key: :region,
                                       env_name: "AWS_SNS_REGION",
                                       description: "AWS Region",
                                       optional: false,
                                       default_value: ENV['AWS_REGION']),
          FastlaneCore::ConfigItem.new(key: :topic_arn,
                                       env_name: "AWS_SNS_TOPIC_ARN",
                                       description: "AWS SNS topic ARN for the topic to send message to",
                                       optional: false,
                                       default_value: ENV['AWS_SNS_TOPIC_ARN']),
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: "AWS_SNS_TOPIC_MESSAGE",
                                       description: "The message you want to send to the AWS SNS topic",
                                       optional: false,
                                       default_value: ENV['AWS_SNS_TOPIC_MESSAGE']),
          FastlaneCore::ConfigItem.new(key: :subject,
                                       env_name: "AWS_SNS_TOPIC_SUBJECT",
                                       description: "The subject you want to send to the AWS SNS topic",
                                       optional: false,
                                       default_value: ENV['AWS_SNS_TOPIC_SUBJECT'])
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
