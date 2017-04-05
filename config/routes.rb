Rails.application.routes.draw do

  get 'sessions/new'

  root 'dashboard#index'

  resources :users do
    resources :messages
    resources :drafts, only: [:index, :destroy]
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
