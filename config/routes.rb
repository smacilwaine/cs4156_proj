Rails.application.routes.draw do
  #get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   
  resources :user, only: [:new, :create]

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  root 'sessions#welcome'
  
  get 'authorized', to: 'sessions#page_requires_login'
    
  post 'logout', to: 'sessions#logout'
  #root 'welcome#index'
end
