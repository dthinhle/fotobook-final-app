Rails.application.routes.draw do
  get 'profiles/myprofile'
  devise_for :users
  get 'home', to: 'feed#home', as: 'home'
  get 'discover', to: 'feed#discover', as: 'discover'
  get 'myprofile', to: 'profiles#myprofile', as: 'myprofile'
  post 'task', to: 'profiles#task'
  get 'albumpreview', to: 'feed#albumpreview'
  get 'photopreview', to: 'feed#photopreview'
  get 'editprofile', to: 'profiles#editprofile', as: 'editprofile'
  get 'getphotos',to: 'profiles#getprofilephotos', as: 'getphotos'
  get 'getfollows', to: 'profiles#getprofilefollows', as: 'getfollows'
  resources 'profiles', only: ['show', 'edit'] do
    patch 'update_password'
    patch 'update_info'
    patch 'update_avatar'
  end

  resources 'photos', 'albums', only: ['show','edit','update','destroy']

  resources 'follows', only: ['create', 'destroy']

  root 'feed#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
