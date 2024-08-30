# frozen_string_literal: true

class SurveyResponsesController < ApplicationController

  include RescueErrors

  def new
    @survey = Survey.find(params[:survey_id])
    @survey_response = SurveyResponse.new
  end

  def create
    ActiveRecord::Base.transaction do
      CreateSurveyResponse::EntryPoint.call(survey_id: params[:survey_id], params: survey_response_params)
    end

    redirect_to surveys_path, notice: 'Thank you for taking this survey.'
  end

  private

  def survey_response_params
    params.require(:survey_response).permit(:answer).to_h
  end

end
