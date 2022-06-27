class MyorderController < ApplicationController
  before_action :authenticate_user!
  def success
  end

  def myorder
    @bought_items = current_user.bought_orders
    @sold_items = current_user.sold_orders
  end
end
