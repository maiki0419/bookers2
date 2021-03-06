Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'home/about'=>'homes#about'
  get '/searches/search' => 'searches#search',as: 'searches'
  get '/searches/categorysearch' => 'searches#categorysearch'

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do

    resources :reviews, only: [:create]
    resources :book_comments, only: [:create,:destroy]
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    resources :groups, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      get 'join' => 'groups#join'
      get 'out' => 'groups#out'
      get 'contact' => 'groups#contact'
      post 'contact' => 'groups#contact_create'

    end
    get :followings, on: :member
    get :followers,on: :member
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end