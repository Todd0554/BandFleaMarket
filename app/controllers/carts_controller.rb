class CartsController < ProductsController
  before_action :current_cart
  before_action :set_product_in_cart

  def index

  end

  def place_orders
    
    @cartproducts.each do |pc|
      buy_product = Product.find_by(id: pc.product_id)
      Order.create(
        product_id: pc.product_id,
        buyer_id: current_user.id,
        seller_id: buy_product.user_id
      )
      buy_product.sold = true
      buy_product.save
    end
    redirect_to order_success_path
  end


  def current_cart
    if session[:cart_id] != nil
      cart = Cart.find_by(user_id: current_user.id)
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id] == nil
      @current_cart = Cart.create(user_id: current_user.id)
      session[:cart_id] = @current_cart.id
    end
  end

  def cart_params
    params.require(:cart).permit(:product_id, :buyer_id, :seller_id)
  end

  def set_product_in_cart
    @cartproducts = CartProduct.where(cart_id: @current_cart.id)
  end
end
