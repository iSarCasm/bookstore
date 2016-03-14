Rails.application.routes.draw do
  mount ShoppingCart::Engine => "/cart"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: 'registrations',
                                  omniauth_callbacks: "callbacks"}
  root 'pages#index', as: :index
  get  '/shop', to: 'pages#shop', as: :shop
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  resources :books, only: [:show]
  resources :authors, only: [:show]

  resources :orders, only: [:show, :index, :update]

  resources :checkouts, only: [:update] do
    member do
      get :edit_address
      get :edit_delivery
      get :edit_payment
      get :confirm
      post :place
    end
  end

  resources :reviews, only: [:create]
end
