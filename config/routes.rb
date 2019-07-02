Rails.application.routes.draw do
  get 'profiles/myprofile'
  devise_for :users
  get 'home', to: 'feed#home', as: 'home'
  get 'discover', to: 'feed#discover', as: 'discover'
  get 'myprofile', to: 'profiles#myprofile'
  resources 'profiles', only: ['show', 'update', 'edit']

  root 'feed#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
