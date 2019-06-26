Rails.application.routes.draw do
  devise_for :users

  get 'welcome/signin'
  get 'feed/home'
  root 'welcome#signin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
