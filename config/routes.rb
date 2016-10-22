Rails.application.routes.draw do
  root 'albums#index'

  resources :users, only: [:new, :create, :show]
  resources :confirmations, only: [:new, :create]
  resources :albums, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  resources :photos, only: [:show, :new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
