class CartsController < ApplicationController
  before_action :set_cart

  # GET /cart
  def show
    @products = Product.where(id: @cart.keys)
  end

  # POST /cart/add/:id
  def add
    product_id = params[:id].to_s

    @cart[product_id] ||= 0
    @cart[product_id] += 1

    save_cart
    redirect_to cart_path, notice: "Product added to cart."
  end

  # PATCH /cart/update/:id
  def update
    product_id = params[:id].to_s
    quantity   = params[:quantity].to_i

    if quantity <= 0
      @cart.delete(product_id)
    else
      @cart[product_id] = quantity
    end

    save_cart
    redirect_to cart_path, notice: "Cart updated."
  end

  # DELETE /cart/remove/:id
  def remove
    product_id = params[:id].to_s
    @cart.delete(product_id)

    save_cart
    redirect_to cart_path, notice: "Item removed from cart."
  end

  private

  def set_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def save_cart
    session[:cart] = @cart
  end
end
