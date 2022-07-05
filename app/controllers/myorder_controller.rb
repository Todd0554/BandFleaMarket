class MyorderController < ApplicationController
  before_action :authenticate_user!

  # success page
  def success
  end

  # page of check ordering history
  def myorder
    @bought_items = current_user.bought_orders
    @sold_items = current_user.sold_orders
  end
end
