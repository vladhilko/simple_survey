# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/surveys'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/surveys/new'
      expect(response).to have_http_status(:success)
    end
  end
end
