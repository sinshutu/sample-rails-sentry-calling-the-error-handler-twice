# frozen_string_literal: true

DiscardError = Class.new(StandardError)
class ApplicationJob < ActiveJob::Base
  RETRY_LIMIT = 3

  rescue_from StandardError do |error|
    if executions <= RETRY_LIMIT
      logger.info('Retry Job')
      retry_job(wait: delay, error: error)
    else
      logger.info('Dead Job')
      ErrorHandling.run(error)
      raise error
    end
  end

  def delay
    60 + (executions**5)
  end
end
