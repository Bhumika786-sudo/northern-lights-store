class StorefrontController < ApplicationController

  def index
    @products = Product.order(created_at: :desc).page(params[:page]).per(6)
  end

  def search
    @keyword = params[:keyword]
    @category = params[:category]

    @products = Product.all

    if @keyword.present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end

    if @category.present? && @category != ""
      @products = @products.where(category_id: @category)
    end

    @products = @products.page(params[:page]).per(6)
  end
end
