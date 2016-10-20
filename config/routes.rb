Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:new, :create, :show]
  resources :confirmations, only: [:new, :create]
  resources :albums, only: [:index, :show, :new, :create]
  resources :photos, only: [:show, :new, :create]
end
