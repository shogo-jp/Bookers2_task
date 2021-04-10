Rails.application.routes.draw do
  devise_for :fons
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
end
  patch 'users/:id' => 'users#update'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :fovorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
