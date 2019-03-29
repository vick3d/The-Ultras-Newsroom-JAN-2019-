Rails.application.routes.draw do  
    devise_for :users
   
    root controller: :articles, action: :index

    resources :articles, only: [:index, :show]
    resources :subscriptions, only: [:new, :create]
    
    namespace :journalist do
        resources :articles
    end

    namespace :editor do
        resources :articles
    end

    namespace :api do
        resources :articles, only: [:index]

        namespace :v1 do
            mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
        end
    end
end