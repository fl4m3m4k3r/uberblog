Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy, :update, :edit]

  resources :users
  resources :likes, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
