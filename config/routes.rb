Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :index
  resources :books, only: [:show]
  resources :authors, only: [:show]
end
