Rails.application.routes.draw do
  
    devise_for :users
    root controller: :articles, action: :index
    resources :articles, only: [:index, :new, :create, :show]
    resources :subscriptions, only: [:index, :create]    
end