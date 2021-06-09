Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books do
    resources :book_comments, only: [:create, :destroy]

    resource :favorites, only: [:create, :destroy]
  end

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followers' => 'relationships#followers', as: :followers
    get 'followings' => 'relationships#followings', as: :following
  end
end