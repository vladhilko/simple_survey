# frozen_string_literal: true

module RescueErrors
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ActiveModel::ValidationError, with: :handle_validation_error
  end

  private

  def handle_record_invalid(exception)
    redirect_back fallback_location: root_path,
                  alert: "There was an error with your submission: #{exception.record.errors.full_messages.join(', ')}"
  end

  def handle_validation_error(exception)
    redirect_back fallback_location: root_path,
                  alert: "There was an error with your submission: #{exception.model.errors.full_messages.join(', ')}"
  end
end
