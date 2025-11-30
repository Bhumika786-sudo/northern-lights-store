class CheckoutController < ApplicationController
  include BreadcrumbsHelper

  before_action :authenticate_user!
  before_action :set_breadcrumbs
  before_action :load_cart

  def new
    @order = Order.new
  end

  def create
    load_cart
    if @cart_items.blank?
      redirect_to cart_path, alert: "Your cart is empty. Please add items before checking out."
      return
    end

    # Create the order
    order = current_user.orders.create!(
      customer_name: params[:name],
      address:       params[:address],
      city:          params[:city],
      province:      params[:province],
      subtotal:      @subtotal,
      gst:           @gst,
      pst:           @pst,
      hst:           @hst,
      total:         @total,
      status:        "new"
    )

    # Create the line items
    @cart_items.each do |product, quantity, line_total|
      order.order_items.create!(
        product:    product,
        quantity:   quantity,
        unit_price: product.current_price,
        line_total: line_total
      )
    end

    # Clear the cart
    session[:cart] = {}

    redirect_to order_path(order), notice: "Thank you! Your order has been placed."
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Could not place order: #{e.message}"
    @order = Order.new
    render :new, status: :unprocessable_entity
  end

  private

  def set_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Checkout", checkout_path
  end

  # Builds @cart_items and totals from session[:cart]
  def load_cart
    cart = session[:cart] || {}

    @cart_items = []
    @subtotal   = 0.0

    cart.each do |product_id, qty|
      product = Product.find_by(id: product_id)
      next unless product

      quantity   = qty.to_i
      line_total = product.current_price * quantity

      @cart_items << [product, quantity, line_total]
      @subtotal   += line_total
    end

    # Replace these with your real tax logic if you have provinces table
    @gst  = (@subtotal * 0.05).round(2)
    @pst  = 0
    @hst  = 0
    @total = (@subtotal + @gst + @pst + @hst).round(2)
  end
end
