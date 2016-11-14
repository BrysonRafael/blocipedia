Rails.application.routes.draw do
  resources :wikis

  devise_for :models
  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
