Rails.application.routes.draw do
  get 'mycart/index', as: "my_cart"
  get 'myorder/success'
  get 'myorder/myorder'
  root to: 'pages#index'
  get 'pages/myshop', to: "pages#myshop", as: "myshop"
  get 'pages/mycart', to: "pages#mycart", as: "mycart"
  
  devise_for :users
  
  resources :products
  get 'show_by_sort/:id', to: "products#show_by_sort", as: "sort"

  post 'products/:id/order', to: "products#place_order", as: "order"
  
  get 'myorder/success', to: "myorder#success", as: "order_success"
  get 'myorder', to: "myorder#myorder", as: "my_order"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
