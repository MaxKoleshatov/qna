# frozen_string_literal: true

Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  resources :questions do
    resources :answers, shallow: true do
      post :set_as_the_best, on: :member
      resources :comments, shallow: true
    end
    resources :comments, shallow: true
  end

  root to: 'welcome#index'

  resources :prizes

  resources :attachments, only: %i[destroy]

  resources :links, only: %i[destroy]
 
  resources :questions do
    post :plus_vote, on: :member
    post :minus_vote, on: :member
    post :delete_vote, on: :member
  end

  resources :answers do
    post :plus_vote, on: :member
    post :minus_vote, on: :member
    post :delete_vote, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: %i[index] do
        get :me, on: :collection
      end
      resources :questions do
        resources :answers, shallow: true
      end
    end
  end

  mount ActionCable.server => '/cable'
end
