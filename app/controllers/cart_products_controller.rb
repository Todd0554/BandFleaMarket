class CartProductsController < ApplicationController
  before_action :current_cart
  
  def create
    chosen_product = Product.find(params[:product_id])
    @cart_product = CartProduct.new
    @cart_product.cart = @current_cart
    @cart_product.product = chosen_product
    @cart_product.save
    redirect_to products_path
  end

  def destroy
  end


  def line_item_params
    params.require(:cart_product).permit(:product_id, :cart_id)
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
  def product_params
    params.require(:product).permit(:title, :description, :user_id, :sold, :price, :category_id, :picture, :sort_id)
  end
end
