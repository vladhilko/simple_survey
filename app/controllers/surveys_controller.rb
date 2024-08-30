# frozen_string_literal: true

class SurveysController < ApplicationController

  include RescueErrors

  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
  end

  def create
    ActiveRecord::Base.transaction { CreateSurvey::EntryPoint.call(params: survey_params) }

    redirect_to surveys_path, notice: 'Survey was successfully created.'
  end

  private

  def survey_params
    params.require(:survey).permit(:question).to_h
  end

end
