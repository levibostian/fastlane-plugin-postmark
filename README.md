# aws_sns_topic plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-aws_sns_topic)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-aws_sns_topic`, add it to your project by running:

```bash
fastlane add_plugin aws_sns_topic
```

## About aws_sns_topic

Fastlane plugin to public message to SNS topic.

This plugin can be very handy to notify a group of people about a new app release. Create a AWS SNS topic, add recipient email addresses to the topic, then send a message to that topic with this plugin. Done! 

## Example

```ruby
notification_message_body = [
    "App v#{versionOfApp}, build: #{buildVersion} ready for download.",
    "\n",
    "What has changed in this latest release?",
    changelog
].join("\n") + "\n"

aws_sns_topic(
    access_key: ENV['S3_ACCESS_KEY'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region: 'us-east-1',
    topic_arn: 'arn:aws:sns:us-east-1:167512897889:topic-name-here',
    subject: "App v#{versionOfApp} ready for download",
    message: notification_message_body
)
```

*Note: It is recommended to not store the AWS access keys in the `Fastfile`.*

*Note: The only permissions you need to add to your AWS IAM user is `SNS:Publish` to the SNS topic you created.*

## Development

```
bundle install 
```

To run both the tests, and code style validation, run

```
bundle exec rake
```

To automatically fix many of the styling issues, use
```
bundle exec rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
