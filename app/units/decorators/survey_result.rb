# frozen_string_literal: true

module Decorators
  class SurveyResult < SimpleDelegator

    def pie_chart
      return {} if responses_count.zero?

      {
        "Yes (#{positive_responses_percentage}%)": positive_responses_count,
        "No (#{negative_responses_percentage}%)": negative_responses_count
      }
    end

    def positive_responses_percentage
      return 0 if responses_count.zero?

      ((positive_responses_count / responses_count.to_f) * 100).round(2)
    end

    def negative_responses_percentage
      return 0 if responses_count.zero?

      ((negative_responses_count / responses_count.to_f) * 100).round(2)
    end

  end
end
