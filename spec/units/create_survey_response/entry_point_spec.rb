# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateSurveyResponse::EntryPoint do
  subject(:entry_point) { described_class.new(survey_id: survey.id, params: params) }

  let(:survey) { create(:survey) }
  let(:survey_result) { create(:survey_result, survey: survey) }

  describe '.call' do
    before { survey_result }

    context 'when params are invalid' do
      context 'when answer is nil' do
        let(:params) { { answer: nil } }

        it 'raises a validation error and does not create a survey response' do
          expect { entry_point.call }.to raise_error(ActiveModel::ValidationError)

          expect(SurveyResponse.count).to eq(0)
          expect(survey_result.reload).to have_attributes(
            responses_count: 0,
            positive_responses_count: 0,
            negative_responses_count: 0
          )
        end
      end
    end

    context 'when params are valid' do
      context 'when response is positive' do
        let(:params) { { answer: true } }

        it 'creates a survey response and updates the survey result' do
          expect { entry_point.call }
            .to change(SurveyResponse, :count).from(0).to(1)
            .and change { survey_result.reload.responses_count }.from(0).to(1)
            .and change { survey_result.reload.positive_responses_count }.from(0).to(1)

          expect(survey_result.reload.negative_responses_count).to eq(0)

          survey_response = SurveyResponse.last
          expect(survey_response).to have_attributes(
            survey_id: survey.id,
            answer: true
          )
        end
      end

      context 'when response is negative' do
        let(:params) { { answer: false } }

        it 'creates a survey response and updates the survey result' do
          expect { entry_point.call }
            .to change(SurveyResponse, :count).from(0).to(1)
            .and change { survey_result.reload.responses_count }.from(0).to(1)
            .and change { survey_result.reload.negative_responses_count }.from(0).to(1)

          expect(survey_result.reload.positive_responses_count).to eq(0)

          survey_response = SurveyResponse.last
          expect(survey_response).to have_attributes(
            survey_id: survey.id,
            answer: false
          )
        end
      end
    end
  end
end
