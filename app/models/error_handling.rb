# frozen_string_literal: true

# special error handling
class ErrorHandling
  class << self
    def run(error)
      logger.info("ErrorHandling #{error}")
    end
  end
end
