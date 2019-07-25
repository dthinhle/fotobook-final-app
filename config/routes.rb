Rails.application.routes.draw do
  devise_for :users

  # Feeds controller

  get 'home', to: 'feeds#home', as: 'home'
  get 'load_home', to: 'feeds#load_home'
  get 'discover', to: 'feeds#discover', as: 'discover'
  get 'load_discover', to: 'feeds#load_discover'
  get 'album_preview', to: 'feeds#album_preview'
  get 'photo_preview', to: 'feeds#photo_preview'
  get 'blocked', to: 'feeds#blocked', as: 'blocked'

  # Profiles controller

  get 'my_profile', to: 'profiles#my_profile', as: 'my_profile'
  post 'task', to: 'profiles#task'
  get 'edit_profile', to: 'profiles#edit_profile', as: 'edit_profile'
  get 'get_photos',to: 'profiles#get_profile_photos', as: 'get_photos'
  get 'load_photos', to: 'profiles#load_photos'
  get 'load_follows', to: 'profiles#load_follows'
  get 'get_follows', to: 'profiles#get_profile_follows', as: 'get_follows'
  resources 'profiles', only: ['show', 'edit'] do
    patch 'update_password'
    patch 'update_info'
    patch 'update_avatar'
    delete 'remove_avatar'
  end

  # Photos and Albums interaction

  resources 'photos', 'albums', except: ['show'] do |item|
    post 'like'
    post 'unlike'
  end

  resources 'follows', only: ['create', 'destroy']

  # Admin dashboard

  namespace :admin do
    resources 'photos', except: ['new', 'create', 'show']
    resources 'albums', except: ['new', 'create', 'show']
    resources 'users', except: ['new', 'create', 'show']
    patch 'users/:id/avatar', to: 'users#update_avatar', as: 'update_avatar'
    delete 'users/:id/avatar', to: 'users#remove_avatar', as:  'remove_avatar'
  end

  authenticated :user do
    root 'feeds#home', as: :authenticated_root
  end

  # Notification channel

  mount ActionCable.server => '/cable'
  post 'seen', to: "profiles#seen"

  root 'feeds#discover'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
