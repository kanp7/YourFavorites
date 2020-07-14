Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'

  resources :books do
    resources :comments, only: [:create, :destroy]
  end
  resources :movies do
    resources :comments, only: [:create, :destroy]
  end
  resources :users do
  	member do
  		get :following, :followers
  	end
  end
  resources :relationships, only:[:create, :destroy]

end
