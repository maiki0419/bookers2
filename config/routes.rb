Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'home/about'=>'homes#about'
  get '/searches/search' => 'searches#search',as: 'searches'
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers,on: :member
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end