class CartsController < ApplicationController
  before_action :current_cart

  def index

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

end
