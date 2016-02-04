Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#index', as: :index
  resources :books, only: [:show]
  resources :authors, only: [:show]
  get   'cart', to: 'shopping_carts#show',      as: :cart
  patch 'cart', to: 'shopping_carts#update',    as: :cart_update
  post  'cart', to: 'shopping_carts#checkout',  as: :checkout
end
