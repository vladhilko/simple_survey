# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSurveyResult::EntryPoint do
  subject(:entry_point) { described_class.new(survey_id: survey.id) }

  let(:survey) { create(:survey) }
  let(:survey_result) do
    create(:survey_result, survey: survey, responses_count: 0, positive_responses_count: 0, negative_responses_count: 0)
  end

  describe '.call' do
    before { survey_result }

    context 'when there are no survey_responses' do
      it 'does not change survey_result counts' do
        expect { entry_point.call }
          .not_to(change do
                    survey_result.reload.attributes.slice(
                      'responses_count',
                      'positive_responses_count',
                      'negative_responses_count'
                    )
                  end)
        expect(survey_result).to have_attributes(
          responses_count: 0,
          positive_responses_count: 0,
          negative_responses_count: 0
        )
      end
    end

    context 'when there are 2 positive responses' do
      before do
        create_list(:survey_response, 2, survey: survey, answer: true)
      end

      it 'updates survey_result with correct counts' do
        expect { entry_point.call }
          .to change {
                survey_result.reload.attributes.slice(
                  'responses_count',
                  'positive_responses_count',
                  'negative_responses_count'
                )
              }
          .from('responses_count' => 0,
                'positive_responses_count' => 0,
                'negative_responses_count' => 0)
          .to('responses_count' => 2,
              'positive_responses_count' => 2,
              'negative_responses_count' => 0)
      end
    end

    context 'when there are 2 negative responses' do
      before do
        create_list(:survey_response, 2, survey: survey, answer: false)
      end

      it 'updates survey_result with correct counts' do
        expect { entry_point.call }
          .to change {
                survey_result.reload.attributes.slice(
                  'responses_count',
                  'positive_responses_count',
                  'negative_responses_count'
                )
              }
          .from('responses_count' => 0,
                'positive_responses_count' => 0,
                'negative_responses_count' => 0)
          .to('responses_count' => 2,
              'positive_responses_count' => 0,
              'negative_responses_count' => 2)
      end
    end

    context 'when there are both positive and negative responses' do
      before do
        create(:survey_response, survey: survey, answer: true)
        create(:survey_response, survey: survey, answer: false)
      end

      it 'updates survey_result with correct counts' do
        expect { entry_point.call }
          .to change {
                survey_result.reload.attributes.slice(
                  'responses_count',
                  'positive_responses_count',
                  'negative_responses_count'
                )
              }
          .from('responses_count' => 0,
                'positive_responses_count' => 0,
                'negative_responses_count' => 0)
          .to('responses_count' => 2,
              'positive_responses_count' => 1,
              'negative_responses_count' => 1)
      end
    end
  end
end
