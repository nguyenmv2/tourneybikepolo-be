# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_token, only: [:create]
  resources :registrations, except: [:index]
  resources :tournament_staffs, except: [:index]
  resources :enrollments, only: [:create, :destroy]
  resources :tournaments
  resources :rosters, except: [:index, :show]
  resources :teams, except: [:index]
  resources :users
end
