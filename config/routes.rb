Rails.application.routes.draw do
  devise_for :users

  # Feeds controller

  get 'home', to: 'feeds#home', as: 'home'
  get 'loadhome', to: 'feeds#loadhome'
  get 'discover', to: 'feeds#discover', as: 'discover'
  get 'loaddiscover', to: 'feeds#loaddiscover'
  get 'albumpreview', to: 'feeds#albumpreview'
  get 'photopreview', to: 'feeds#photopreview'

  # Profiles controller

  get 'myprofile', to: 'profiles#myprofile', as: 'myprofile'
  post 'task', to: 'profiles#task'
  get 'editprofile', to: 'profiles#editprofile', as: 'editprofile'
  get 'getphotos',to: 'profiles#getprofilephotos', as: 'getphotos'
  get 'loadphotos', to: 'profiles#loadphotos'
  get 'loadfollows', to: 'profiles#loadfollows'
  get 'getfollows', to: 'profiles#getprofilefollows', as: 'getfollows'
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
    get 'managephotos', to: 'managements#photos'
    get 'photos/:id', to: 'managements#editphoto', as: 'editphoto'
    patch 'photos/:id', to: 'managements#updatephoto', as: 'updatephoto'
    get 'managealbums', to: 'managements#albums'
    get 'albums/:id', to: 'managements#editalbum', as: 'editalbum'
    patch 'albums/:id', to: 'managements#updatealbum', as: 'updatealbum'
    get 'manageusers', to: 'managements#users'
    get 'users/:id/edit', to: 'managements#edituser', as: 'edituser'
    patch 'users/:id', to: 'managements#updateavtuser', as: 'updateavtuser'
    patch 'users/:id', to: 'managements#updateuser', as: 'updateuser'
    delete 'users/:id', to: 'managements#deleteuser', as: 'deleteuser'
  end

  authenticated :user do
    root 'feeds#home', as: :authenticated_root
  end
  root 'feeds#discover'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
