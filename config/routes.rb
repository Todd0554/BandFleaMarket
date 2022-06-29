Rails.application.routes.draw do
  get 'cart', to:"carts#index", as: "cart"
  get 'carts/:id', to: "carts#show"
  delete 'carts/:id', to: "carts#destroy"
  post 'cart_products', to: "cart_products#create"
  delete 'cart_products/:id', to: "cart_products#destroy", as: "remove_product_from_cart" 


  get 'myorder/success'
  get 'myorder/myorder'
  root to: 'pages#index'
  get 'pages/myshop', to: "pages#myshop", as: "myshop"
  
  
  devise_for :users
  
  resources :products
  get 'show_by_sort/:id', to: "products#show_by_sort", as: "sort"
  post 'products/:id/order', to: "products#place_order", as: "order"
  get 'myorder/success', to: "myorder#success", as: "order_success"
  get 'myorder', to: "myorder#myorder", as: "my_order"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'cart/place_orders', to: "carts#place_orders", as: "orders"
end
