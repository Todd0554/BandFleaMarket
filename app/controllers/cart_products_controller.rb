class CartProductsController < ApplicationController
  before_action :current_cart, only: %i[ create destroy]
  
  def create
    chosen_product = Product.find(params[:product_id])
    @cart_product = CartProduct.new
    @cart_product.cart = @current_cart
    @cart_product.product = chosen_product
    @cart_product.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end




  private
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
  # Only allow a list of trusted parameters through.
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :cart_id)
  end
end
