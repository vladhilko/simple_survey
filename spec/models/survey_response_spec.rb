# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyResponse, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:survey) }
  end
end
