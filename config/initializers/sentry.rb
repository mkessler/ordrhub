Raven.configure do |config|
  config.dsn = ENV['SENTRY_API_KEY']
  config.environments = ['production']
end
