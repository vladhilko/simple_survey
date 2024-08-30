# frozen_string_literal: true

FactoryBot.define do
  factory :survey_result do
    association :survey
    responses_count { 0 }
    positive_responses_count { 0 }
    negative_responses_count { 0 }
  end
end
