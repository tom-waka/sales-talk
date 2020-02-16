Rails.application.routes.draw do
  get 'users/new'
  get 'users/edit'
  get 'users/show'
  root to: 'articles#index'
  resources :articles
end
