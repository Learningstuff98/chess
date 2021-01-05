Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :games, only: [:new, :create, :show, :destroy]
  resources :pieces, only: [:update]
end
