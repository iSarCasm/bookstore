Rails.application.routes.draw do
  get '/(:page)', to: 'pages#index', as: :index_page
  resources :books, only: [:show]
  resources :authors, only: [:show]
end
