Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: 'registrations',
                                  omniauth_callbacks: "callbacks"}
  root 'pages#index', as: :index

  resources :books, only: [:show]
  resources :authors, only: [:show]

  get     'cart', to: 'shopping_carts#show'
  patch   'cart', to: 'shopping_carts#update'
  delete  'cart', to: 'shopping_carts#clear'
  post    'cart', to: 'shopping_carts#checkout',  as: :checkout

  resources :orders, only: [:show, :index, :update]

  resources :checkouts, only: [:update] do
    get :edit_address,  on: :member
    get :edit_delivery, on: :member
    get :edit_payment,  on: :member
    get :confirm,       on: :member
    post :place,        on: :member
  end

  resources :reviews, only: [:create]
end
