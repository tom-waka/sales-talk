Rails.application.routes.draw do
  root to: 'articles#index'
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :articles do
    resource :likes, only: [:create, :destroy]
  end
end
