Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#index', as: :index

  resources :books, only: [:show]
  resources :authors, only: [:show]

  get   'cart', to: 'shopping_carts#show',      as: :cart
  patch 'cart', to: 'shopping_carts#update',    as: :cart_update
  post  'cart', to: 'shopping_carts#checkout',  as: :checkout

  get   'orders/:id/edit_address',  to: 'orders#edit_address',   as: :edit_address
  get   'orders/:id/edit_delivery', to: 'orders#edit_delivery',  as: :edit_delivery
  get   'orders/:id/edit_payment',  to: 'orders#edit_payment',   as: :edit_payment
  get   'orders/:id/confirm',       to: 'orders#confirm',        as: :confirm
  post  'orders/:id/place',         to: 'orders#place',          as: :place
  resources :orders, only: [:show, :index, :update]
end
