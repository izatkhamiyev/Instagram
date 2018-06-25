Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  resources :users
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts, only: [:create, :destroy]
 # resources :likes, only: [:create]
  post '/like', to: 'likes#create'
  delete '/unlike', to: "likes#destroy"
end
