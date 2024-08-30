# frozen_string_literal: true

Rails.application.routes.draw do
  root 'surveys#index'
  resources :surveys, only: %i[index new create]
end
