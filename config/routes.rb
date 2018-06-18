Rails.application.routes.draw do
  get 'pages/about', to: 'pages#about'
  get 'pages/contact', to: 'pages#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
end
