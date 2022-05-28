# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, shallow: true do
      post :set_as_the_best, on: :member
      post :plus_vote, on: :member
      post :minus_vote, on: :member
      post :delete_vote, on: :member
    end
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
end
