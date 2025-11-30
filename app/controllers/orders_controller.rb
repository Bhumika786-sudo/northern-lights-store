class OrdersController < ApplicationController
  include BreadcrumbsHelper

  before_action :set_breadcrumbs
  before_action :set_order, only: [ :show ]

  def index
    @orders = current_user.orders
  end

  def show
    add_breadcrumb "Order ##{@order.id}"
  end

  private

  def set_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Orders", orders_path
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
