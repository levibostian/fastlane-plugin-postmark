# postmark plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-postmark)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-postmark`, add it to your project by running:

```bash
fastlane add_plugin postmark
```

## About 

Fastlane plugin to send emails via [Postmark](https://postmarkapp.com/).

This plugin can be very handy to notify a group of people about a new app release.

## Example

```ruby
notification_message_body = [
    "App v#{versionOfApp}, build: #{buildVersion} ready for download.",
    "\n",
    "What has changed in this latest release?",
    changelog
].join("\n") + "\n"

postmark(
    api_key: "server-token", # Or, set `POSTMARK_API_KEY` environment variable 
    from: "First Last <you@you.com>", # Or, set `POSTMARK_FROM_EMAIL_ADDRESS` environment variable 
    to: "dana@gmail.com, other-person@example.com", # comma separated list of people to send to. Or, set `POSTMARK_TO_EMAIL_ADDRESS` environment variable 
    subject: "App v#{versionOfApp} ready for download", # Or, set `POSTMARK_EMAIL_SUBJECT` environment variable 
    message_text: notification_message_body, # text only email body. If you want to use HTML instead, leave this blank. 
    message_html: "<h1>...</h1>", # HTML email body. If you want to use text instead, leave this blank. 
)
```

*Note: It is recommended to not store the API key in the `Fastfile`.*

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
