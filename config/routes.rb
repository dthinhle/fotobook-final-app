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
  end

  # Photos and Albums interaction

  resources 'photos', 'albums', except: ['show'] do |item|
    post 'like'
    post 'unlike'
  end

  resources 'follows', only: ['create', 'destroy']

  # Admin dashboard

  namespace :admin do
    get 'manage_photos', to: 'managements#photos'
    get 'photos/:id', to: 'managements#edit_photo', as: 'edit_photo'
    patch 'photos/:id', to: 'managements#update_photo', as: 'update_photo'
    get 'manage_albums', to: 'managements#albums'
    get 'albums/:id', to: 'managements#editalbum', as: 'edit_album'
    patch 'albums/:id', to: 'managements#updatealbum', as: 'update_album'
    get 'manage_users', to: 'managements#users'
    get 'users/:id/edit', to: 'managements#edit_user', as: 'edit_user'
    patch 'users/:id/avatar', to: 'managements#update_avt_user', as: 'update_avt_user'
    patch 'users/:id', to: 'managements#update_user', as: 'update_user'
    delete 'users/:id', to: 'managements#delete_user', as: 'delete_user'
  end

  authenticated :user do
    root 'feeds#home', as: :authenticated_root
  end

  root 'feeds#discover'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
