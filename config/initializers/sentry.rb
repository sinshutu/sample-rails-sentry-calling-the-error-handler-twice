# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.rails.report_rescued_exceptions = true
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.traces_sample_rate = 0.2
end
