# frozen_string_literal: true

class Survey < ApplicationRecord

  has_many :survey_responses, dependent: :destroy
  has_one :survey_result, dependent: :destroy

end
