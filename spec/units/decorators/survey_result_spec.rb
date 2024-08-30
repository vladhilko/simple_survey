# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Decorators::SurveyResult do
  let(:survey_result) do
    build_stubbed(:survey_result, responses_count: responses_count,
                                  positive_responses_count: positive_responses_count,
                                  negative_responses_count: negative_responses_count)
  end
  let(:decorator) { described_class.new(survey_result) }

  describe '#pie_chart' do
    context 'when responses_count is zero' do
      let(:responses_count) { 0 }
      let(:positive_responses_count) { 0 }
      let(:negative_responses_count) { 0 }

      it 'returns an empty hash' do
        expect(decorator.pie_chart).to eq({})
      end
    end

    context 'when responses are present' do
      let(:responses_count) { 10 }
      let(:positive_responses_count) { 7 }
      let(:negative_responses_count) { 3 }

      it 'returns a hash with formatted pie chart data' do
        expect(decorator.pie_chart).to eq({
                                            "Yes (70.0%)": 7,
                                            "No (30.0%)": 3
                                          })
      end
    end
  end

  describe '#positive_responses_percentage' do
    context 'when responses_count is zero' do
      let(:responses_count) { 0 }
      let(:positive_responses_count) { 0 }
      let(:negative_responses_count) { 0 }

      it 'returns 0' do
        expect(decorator.positive_responses_percentage).to eq(0)
      end
    end

    context 'when responses are present' do
      let(:responses_count) { 10 }
      let(:positive_responses_count) { 7 }
      let(:negative_responses_count) { 3 }

      it 'returns the correct positive percentage' do
        expect(decorator.positive_responses_percentage).to eq(70.0)
      end
    end
  end

  describe '#negative_responses_percentage' do
    context 'when responses_count is zero' do
      let(:responses_count) { 0 }
      let(:positive_responses_count) { 0 }
      let(:negative_responses_count) { 0 }

      it 'returns 0' do
        expect(decorator.negative_responses_percentage).to eq(0)
      end
    end

    context 'when responses are present' do
      let(:responses_count) { 10 }
      let(:positive_responses_count) { 7 }
      let(:negative_responses_count) { 3 }

      it 'returns the correct negative percentage' do
        expect(decorator.negative_responses_percentage).to eq(30.0)
      end
    end
  end
end
