Rails.application.routes.draw do
  devise_for :users

  get 'welcome/signin'
  get 'myprofile', to: 'profiles#myprofile', as: 'myprofile'
  get 'home', to: 'feed#home', as: 'home'
  get 'discover', to: 'feed#discover', as: 'discover'
  root 'welcome#signin'
  root to: 'feed#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
