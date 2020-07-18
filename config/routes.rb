Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'

  resources :books do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :movies do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users do
  	member do
  		get :following, :followers, :user_posts
  	end
  	resource :favorites, only:[:show]
  end
  resources :relationships, only:[:create, :destroy]

  get 'search' => 'searches#search'


end
