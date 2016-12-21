Rails.application.routes.draw do
  resources :wikis
  resources :charges, only: [:new, :create]

  devise_for :models
  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
