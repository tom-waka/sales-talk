Rails.application.routes.draw do
  root to: 'articles#index'
  get '/signup', to: 'users#new'
  resources :articles
  resources :users
end
