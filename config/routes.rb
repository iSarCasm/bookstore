Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :index
  resources :books, only: [:show]
  resources :authors, only: [:show]
  patch '/add-to-cart', to: 'carts#add', as: :cart_add
end
