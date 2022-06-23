Rails.application.routes.draw do
  get 'pages/myshop', to: "pages#myshop", as: "myshop"
  get 'pages/mycart', to: "pages#mycart", as: "mycart"
  resources :products
  devise_for :users
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
