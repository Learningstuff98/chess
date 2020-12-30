Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :games, only: [:new, :create, :show, :destroy]
end
