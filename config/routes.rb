Rails.application.routes.draw do
  root to: 'pages#index'
  get 'pages/myshop', to: "pages#myshop", as: "myshop"
  get 'pages/mycart', to: "pages#mycart", as: "mycart"
  
  devise_for :users
  
  resources :products
  get 'show_by_sort/:id', to: "products#show_by_sort", as: "sort"


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
