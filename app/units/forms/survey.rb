# frozen_string_literal: true

module Forms
  class Survey

    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :question, :string

    validates :question, presence: true, length: { maximum: 255 }

  end
end
