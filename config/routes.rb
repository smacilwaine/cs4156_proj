Rails.application.routes.draw do
  #get 'lectures/new'
  #get 'lectures/create'
  #get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   
  resources :user, only: [:new, :create]
  
  resources :lectures, only: [:new, :create]

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  root 'sessions#welcome'
  
  get 'authorized', to: 'sessions#page_requires_login'
    
  post 'logout', to: 'sessions#logout'

  get 'dashboard', to: 'user#dashboard'  

  get 'newlecture', to: 'lectures#new'

  post 'newlecture', to: 'lectures#create'

  get 'view/:lec_id', to: 'lectures#view'

  get 'join', to: 'lectures#join'

  post 'validate_join', to: 'lectures#validate_join'

  #get 'teach/:lec_id', to: 'lectures#teach'

  get 'leave/:lec_id', to: 'lectures#leave'

  get 'terminate/:lec_id', to: 'lectures#terminate'
  
  get 'no_access', to: 'lectures#no_access'

  #root 'welcome#index'
end
