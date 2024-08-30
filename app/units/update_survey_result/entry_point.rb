# frozen_string_literal: true

module UpdateSurveyResult
  class EntryPoint

    def self.call(survey_id:)
      new(survey_id: survey_id).call
    end

    def initialize(survey_id:)
      @survey_id = survey_id
    end

    def call
      survey_result = SurveyResult.find_by!(survey_id: survey_id)

      survey_result.update!(
        responses_count: positive_responses_count + negative_responses_count,
        positive_responses_count: positive_responses_count,
        negative_responses_count: negative_responses_count
      )
    end

    private

    attr_reader :survey_id

    def response_counts
      @response_counts ||= SurveyResponse.where(survey_id: survey_id).group(:answer).count
    end

    def positive_responses_count
      response_counts.fetch(true, 0)
    end

    def negative_responses_count
      response_counts.fetch(false, 0)
    end

  end
end
