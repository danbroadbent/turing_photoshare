Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:new, :create, :show]
  resources :confirmations, only: [:new, :create]

  # get '/confirmation', to: 'confirmation#show'
end
