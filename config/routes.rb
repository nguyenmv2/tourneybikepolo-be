# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_token, only: [:create]
  resources :registrations, except: [:index, :new, :edit]
  resources :tournament_staffs, except: [:index, :new, :edit]
  resources :enrollments, only: [:create, :destroy]
  resources :tournaments, except: [:new, :edit]
  resources :rosters, except: [:index, :show, :new, :edit]
  resources :teams, except: [:index, :new, :edit]
  resources :users, except: [:new, :edit]
end
