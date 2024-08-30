# frozen_string_literal: true

Rails.application.routes.draw do
  root 'surveys#index'
  resources :surveys, only: %i[index new create] do
    resources :survey_responses, only: %i[new create]
  end
end
