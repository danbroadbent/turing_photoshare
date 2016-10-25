Rails.application.routes.draw do
  root 'albums#index'
  get 'profile',                  to: 'users#show',  as: 'user'
  get 'dashboard',                to: 'admin#index'
  get 'login',                    to: 'sessions#new'
  post 'login',                   to: 'sessions#create'
  delete 'logout',                to: 'sessions#destroy'
  get 'my_albums',                to: 'my_albums#index'
  get 'album/comments/delete',    to: 'comments#destroy'
  get 'admin/albums/delete',      to: 'admin/albums#destroy'


  namespace :api do
    namespace :v1 do
      resources :albums, only: [:show] do
        resources :comments, except: [:edit, :new]
      end
    end
  end

  resources :users, only: [:new, :create, :update, :edit]
  resources :user_profiles, only: [:edit, :update]
  resources :confirmations, only: [:new, :create]
  resources :albums do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  resources :photos, only: [:show, :new, :create]
  resources :album_users, only: [:new, :create]

  namespace :admin do
    resources :albums, only: [:index]
    resources :users, only: [:index, :edit, :show]
  end
end
