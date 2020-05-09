Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user, only: [:new, :create, :index]

  resources :lectures, only: [:new, :create]

  resource :session, only: [:new, :create, :index, :destroy]

  root 'sessions#index'

  # Replaced sessions
  # root 'sessions#welcome'
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # get 'welcome', to: 'sessions#welcome'
  # get 'authorized', to: 'sessions#page_requires_login'
  # post 'logout', to: 'sessions#logout'

  # Replaced dashboard by :index route in resources :user
  # get 'dashboard', to: 'user#dashboard'  

  # Replaced newlecture by :new route in resources :lectures
  # get 'newlecture', to: 'lectures#new'
  # post 'newlecture', to: 'lectures#create'

  get 'view/:lec_id', to: 'lectures#view'

  get 'join', to: 'lectures#join'

  post 'validate_join', to: 'lectures#validate_join'

  #get 'teach/:lec_id', to: 'lectures#teach'

  get 'leave/:lec_id', to: 'lectures#leave'

  post 'terminate/:lec_id', to: 'lectures#terminate'

  get 'no_access', to: 'lectures#no_access'
end
