Rails.application.routes.draw do
  root 'albums#index'
  get '/profile', to: 'users#show', as: 'user'

  resources :users, only: [:new, :create]
  resources :confirmations, only: [:new, :create]
  resources :albums, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end
  resources :photos, only: [:show, :new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/my_albums', to: 'my_albums#index'
end
