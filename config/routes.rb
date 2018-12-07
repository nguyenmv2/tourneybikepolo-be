# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_token, only: [:create]
  resources :registrations, except: %i[index new edit]
  resources :tournament_staffs, except: %i[index new edit]
  resources :enrollments, only: %i[create destroy]
  resources :tournaments, except: %i[new edit] do
    resources :teams do
      resources :charges, only: :create
    end
  end
  resources :rosters, except: %i[index show new edit]
  resources :teams, except: %i[index new edit]
  resources :users, except: %i[new edit]
end
