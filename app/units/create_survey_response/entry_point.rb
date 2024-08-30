# frozen_string_literal: true

module CreateSurveyResponse
  class EntryPoint

    def self.call(survey_id:, params:)
      new(survey_id: survey_id, params: params).call
    end

    def initialize(survey_id:, params:)
      @survey_id = survey_id
      @form = Forms::SurveyResponse.new(params)
    end

    def call
      form.validate!

      SurveyResponse.create!(form.attributes.merge(survey_id: survey_id)).tap do |_survey_response|
        UpdateSurveyResult::EntryPoint.call(survey_id: survey_id)
      end
    end

    private

    attr_reader :survey_id, :form

  end
end
