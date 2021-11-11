# frozen_string_literal: true

class AnonymousJob < ApplicationJob
  def perform
    raise return_error
  end

  class << self
    def return_error
      StandardError
    end
  end
end
