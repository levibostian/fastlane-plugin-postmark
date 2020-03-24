require 'fastlane_core/ui/ui'
require 'postmark'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PostmarkHelper
      # class methods that you define here become available in your action
      # as `Helper::Postmark.your_method`
      #
    end

    class Postmark
      def initialize(api_key)
        @client = Postmark::ApiClient.new(api_key)
      end

      def send(from, to, subject, message_text, message_html)
        @client.deliver(
          from: from,
          to: to.split(",").map(&:strip),
          subject: subject,
          html_body: message_html,
          text_body: message_text
        )
      rescue => error
        UI.crash!("Send email via Postmark error: #{error.inspect}")
      end
    end
  end
end
