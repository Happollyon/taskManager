# config/routes.rb
# This file defines the routes for the application.
# The routes are matched in the order they are specified,
# so defining root :to => "pages#home" first means that it will be matched
# before match "pages/:id" => "pages#show" gets a chance to.

Rails.application.routes.draw do # This is the router
  get 'pages/home' # This is a route to the home action in the Pages controller
  get "up" => "rails/health#show", as: :rails_health_check # This is a route to the health check
  get 'login', to: 'pages#login' # This is a route to the login action in the Pages controller
  get 'home', to: 'pages#home' # This is a route to the home action in the Pages controller
  get 'register', to: 'pages#register' # This is a route to the register action in the Pages controller
  get 'main', to: 'pages#main' # This is a route to the main action in the Pages controller
  get 'about', to: 'sessions#new', as: 'about' # This is a route to the about action in the Sessions controller
  
  get '/logout', to: 'sessions#destroy', as: :logout # This is a route to the logout action in the Sessions controller

  
  resources :users, only: [:create] do # This is a route to the create action in the Users controller
    resources :tasks, only: [:create] # This is a route to the create action in the Tasks controller 
  end

  resources :sessions, only: [:create] # This is a route to the create action in the Sessions controller
  resources :tasks, only: [:create,:destroy] # This is a route to the create and destroy action in the Tasks controller

  resources :topics, only: [:create, :index, :destroy, :show] do # This is a route to the create, index, destroy, and show action in the Topics controller
  resources :tasks, only: [:index]# This is a route to the index action in the Tasks controller
  end

  resources :tasks, only: [:create] do # This is a route to the create action in the Tasks controller
    member do # This is a route to the toggle action in the Tasks controller
      patch :toggle # This is a route to the toggle action in the Tasks controller
    end
  end

  root 'pages#home' # This is a route to the home action in the Pages controller
end