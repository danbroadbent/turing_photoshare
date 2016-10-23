Rails.application.routes.draw do
  root 'albums#index'
  get 'profile',        to: 'users#show',  as: 'user'
  get 'dashbaord',      to: 'admin#index', as: 'dashboard'
  get 'login',          to: 'sessions#new'
  post 'login',         to: 'sessions#create'
  delete 'logout',      to: 'sessions#destroy'
  get 'my_albums',      to: 'my_albums#index'

  namespace :api do
    namespace :v1 do
      resources :albums, only: [:show] do
        resources :comments, only: [:create, :destroy, :edit, :update, :index]
      end
    end
  end

  resources :users, only: [:new, :create, :update]
  resources :user_profiles, only: [:edit, :update]
  resources :confirmations, only: [:new, :create]
  resources :albums, only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  resources :photos, only: [:show, :new, :create]
end
