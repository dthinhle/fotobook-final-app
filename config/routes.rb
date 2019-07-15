Rails.application.routes.draw do
  devise_for :users

  # Feeds controller

  get 'home', to: 'feeds#home', as: 'home'
  get 'discover', to: 'feeds#discover', as: 'discover'
  get 'albumpreview', to: 'feeds#albumpreview'
  get 'photopreview', to: 'feeds#photopreview'

  # Profiles controller

  get 'myprofile', to: 'profiles#myprofile', as: 'myprofile'
  post 'task', to: 'profiles#task'
  get 'editprofile', to: 'profiles#editprofile', as: 'editprofile'
  get 'getphotos',to: 'profiles#getprofilephotos', as: 'getphotos'
  get 'getfollows', to: 'profiles#getprofilefollows', as: 'getfollows'
  resources 'profiles', only: ['show', 'edit'] do
    patch 'update_password'
    patch 'update_info'
    patch 'update_avatar'
  end

  # Photos and Albums interaction

  resources 'photos', 'albums', except: ['show']

  resources 'follows', only: ['create', 'destroy']

  # Admin dashboard

  namespace :admin do
    get 'managephotos', to: 'managements#photos'
    get 'managealbums', to: 'managements#albums'
    get 'manageusers', to: 'managements#users'
  end

  root 'feeds#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
