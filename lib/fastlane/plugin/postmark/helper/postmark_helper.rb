require 'fastlane_core/ui/ui'
require 'aws-sdk'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PostmarkHelper
      # class methods that you define here become available in your action
      # as `Helper::AwsSnsTopicHelper.your_method`
      #
      def self.verify_params(params, required_params)
        required_params.each do |required_param|
          UI.user_error!("You forgot to pass in the parameter: #{required_param}, pass using `#{required_param}: 'value-here'`") unless params[required_param].to_s.length > 0
        end
      end
    end

    class Postmark
      def initialize(access_key, secret_access_key, region, topic_arn)
        @client = Aws::SNS::Client.new(
          access_key_id: access_key,
          secret_access_key: secret_access_key,
          region: region
        )
        @topic = Aws::SNS::Topic.new(
          arn: topic_arn,
          client: @client
        )
      end

      def publish_message(message, subject)
        @topic.publish({
          message: message,
          subject: subject
        })
      rescue => error
        UI.crash!("Send SNS topic message error: #{error.inspect}")
      end
    end
  end
end
