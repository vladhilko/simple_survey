# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:survey_responses).dependent(:destroy) }
    it { is_expected.to have_one(:survey_result).dependent(:destroy) }
  end
end
