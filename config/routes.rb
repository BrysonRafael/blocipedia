Rails.application.routes.draw do
  devise_for :admins
  resources :wikis
  resources :charges, only: [:new, :create, :update]

  devise_for :models
  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
