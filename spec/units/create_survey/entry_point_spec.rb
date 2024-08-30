# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateSurvey::EntryPoint do
  subject(:entry_point) { described_class.new(params: params) }

  let(:params) { { question: 'hello?' } }

  describe '.call' do
    context 'when params are invalid' do
      context 'when question is nil' do
        let(:params) { { question: nil } }

        it 'raises a validation error' do
          expect { entry_point.call }.to raise_error(ActiveModel::ValidationError)
          expect(Survey.count).to eq(0)
        end
      end

      context 'when question exceeds maximum length' do
        let(:params) { { question: 'a' * 256 } }

        it 'raises a validation error' do
          expect { entry_point.call }.to raise_error(ActiveModel::ValidationError)
          expect(Survey.count).to eq(0)
        end
      end
    end

    context 'when params are valid' do
      let(:params) { { question: 'Is this a valid question?' } }

      it 'creates a survey and associated survey result' do
        expect { entry_point.call }.to change(Survey, :count).from(0).to(1)
          .and change(SurveyResult, :count).from(0).to(1)

        survey = Survey.last
        survey_result = SurveyResult.last

        expect(survey.question).to eq('Is this a valid question?')
        expect(survey_result).to have_attributes(
          survey_id: survey.id,
          responses_count: 0,
          positive_responses_count: 0,
          negative_responses_count: 0
        )
      end
    end
  end
end
