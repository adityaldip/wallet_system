Rails.application.routes.draw do
  namespace :api do
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    get 'me', to: 'users#show'
    resources :teams, only: [:index]
    resources :stocks, only: [:index]
    
    resources :transactions, only: [:create, :index]
    get 'transactions/user', to: 'transactions#user_transactions'
  end

  root 'home#index'
end
