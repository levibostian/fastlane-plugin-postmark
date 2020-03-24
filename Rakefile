# frozen_string_literal: true

task default: %w[build]

task :spec do
  sh 'bundle exec rspec'
end

task :lint do
  sh 'bundle exec rubocop  --auto-correct -c .rubocop.yml'
end

task :build do
  sh 'rm fastlane-plugin-*.gem || true'
  sh 'gem build fastlane-plugin-postmark.gemspec'
end

task :install do
  Rake::Task[:build].invoke
  sh 'gem install fastlane-plugin-postmark*.gem'
end

task :publish do
  Rake::Task[:build].invoke
  sh 'gem push fastlane-plugin-postmark*.gem'
end