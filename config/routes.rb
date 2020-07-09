Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  resources :books
  resources :movies
  resources :users
end
