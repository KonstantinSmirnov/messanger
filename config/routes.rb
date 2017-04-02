Rails.application.routes.draw do


  root 'static_pages#index'
  get 'static_pages/index'

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
