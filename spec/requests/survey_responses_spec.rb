# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SurveyResponses', type: :request do
  describe 'GET /new' do
    let(:survey) { create(:survey) }

    before { survey }

    it 'returns http success' do
      get "/surveys/#{survey.id}/survey_responses/new"
      expect(response).to have_http_status(:success)
    end
  end
end
