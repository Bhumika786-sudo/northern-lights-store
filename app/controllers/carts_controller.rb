class CartsController < ApplicationController
  def show
    cart_hash = session[:cart] || {}

    @cart_items = []
    @subtotal   = 0.0

    cart_hash.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      line_subtotal = product.current_price * quantity.to_i
      @subtotal += line_subtotal

      @cart_items << {
        product:  product,
        quantity: quantity.to_i,
        subtotal: line_subtotal
      }
    end

    @gst   = (@subtotal * 0.05).round(2)
    @pst   = 0
    @hst   = 0
    @total = (@subtotal + @gst + @pst + @hst).round(2)
  end

  def add
    product = Product.find_by(id: params[:id])

    unless product
      flash[:alert] = "That product could not be found."
      return redirect_to products_path
    end

    session[:cart] ||= {}
    session[:cart][product.id.to_s] ||= 0
    session[:cart][product.id.to_s] += 1

    flash[:notice] = "#{product.name} was added to your cart."
    redirect_to cart_path
  end

  def remove
    product = Product.find_by(id: params[:id])
    session[:cart] ||= {}

    if product && session[:cart][product.id.to_s]
      session[:cart][product.id.to_s] -= 1
      session[:cart].delete(product.id.to_s) if session[:cart][product.id.to_s] <= 0
      flash[:notice] = "#{product.name} was removed from your cart."
    else
      flash[:alert] = "That product is not in your cart."
    end

    redirect_to cart_path
  end

  def clear
    session[:cart] = {}
    flash[:notice] = "Your cart has been emptied."
    redirect_to cart_path
  end
end
