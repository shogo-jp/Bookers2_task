Rails.application.routes.draw do
  devise_for :fons
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  resources :users, only: [:index, :show]
  get 'users/:id/edit' => 'users#edit', as: :edit_user
  patch 'users/:id' => 'users#update'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
end
