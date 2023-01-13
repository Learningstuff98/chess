Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'lobby', to: 'pages#lobby'
  get 'tour', to: 'pages#tour'
  resources :games, only: [:new, :create, :show, :destroy] do
    resources :comments, only: [:create]
  end
  resources :pieces, only: [:update]
end
