Rails.application.routes.draw do
  
  devise_for :users
  resources :questions do
    resources :answers, shallow: true do
      post :set_as_the_best, on: :member
    end 
  end

  root to: 'welcome#index'

  resources :prizes

  resources :attachments, only: %i[destroy]

  resources :links, only: %i[destroy]
end

