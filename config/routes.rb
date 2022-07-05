Rails.application.routes.draw do
  # root page
  root to: 'pages#index'
  # cart page
  get 'cart', to:"carts#index", as: "cart"
  get 'carts/:id', to: "carts#show"
  delete 'carts/:id', to: "carts#destroy"
  # cartproducts (the product added to cart by the current user)
  post 'cart_products', to: "cart_products#create"
  delete 'cart_products/:id', to: "cart_products#destroy", as: "remove_product_from_cart" 
  # myShop page
  get 'pages/myshop', to: "pages#myshop", as: "myshop"
  #devise
  devise_for :users
  # products pages + show by sorts and categories
  resources :products
  get 'show_by_category/:id', to: "products#show_by_category", as: "category"
  get 'show_by_sort/:id', to: "products#show_by_sort", as: "sort"
  # order pages and success pages
  post 'products/:id/order', to: "products#place_order", as: "order"
  get 'myorder/success', to: "myorder#success", as: "order_success"
  get 'myorder', to: "myorder#myorder", as: "my_order"
  
  # place several orders together in cart page 
  post 'cart/place_orders', to: "carts#place_orders", as: "orders"
end
