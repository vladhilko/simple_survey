# frozen_string_literal: true

module Forms
  class SurveyResponse

    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :answer, :boolean

    validates :answer, inclusion: { in: [true, false] }

  end
end
