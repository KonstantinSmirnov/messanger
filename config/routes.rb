Rails.application.routes.draw do


  get 'sessions/new'

  root 'dashboard#index'

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
