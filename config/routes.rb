Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'

  resources :books do
    resources :comments, only: [:create, :destroy]
  end
  resources :movies do
    resources :comments, only: [:create, :destroy]
  end
  resources :users
end
