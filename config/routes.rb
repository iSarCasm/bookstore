Rails.application.routes.draw do
  root 'pages#index', as: :index
  resources :books, only: [:show]
  resources :authors, only: [:show]
  patch 'shopping_carts', to: 'shopping_carts#update', as: :cart_update
end
