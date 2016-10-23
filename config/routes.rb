Rails.application.routes.draw do
  root 'albums#index'
  get 'profile',        to: 'users#show', as: 'user'
  get 'dashbaord',      to: 'admin#index', as: 'dashboard'

  resources :users, only: [:new, :create]
  resources :user_profiles, only: [:edit, :update]
  resources :confirmations, only: [:new, :create]
  resources :albums, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  resources :photos, only: [:show, :new, :create]

  get '/login',         to: 'sessions#new'
  post '/login',        to: 'sessions#create'
  delete 'logout',      to: 'sessions#destroy'
end
