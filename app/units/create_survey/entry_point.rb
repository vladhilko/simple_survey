# frozen_string_literal: true

module CreateSurvey
  class EntryPoint

    def self.call(params:)
      new(params: params).call
    end

    def initialize(params:)
      @form = Forms::Survey.new(params)
    end

    def call
      form.validate!

      Survey.create!(form.attributes).tap do |survey|
        SurveyResult.create!(survey: survey)
      end
    end

    private

    attr_reader :form

  end
end
