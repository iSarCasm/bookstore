Rails.application.routes.draw do
  get '/(:page)', to: 'pages#index', as: :index_page
end
