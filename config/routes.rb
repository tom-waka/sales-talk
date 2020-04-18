Rails.application.routes.draw do
  root to: 'articles#index'
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :articles do
    resource :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
