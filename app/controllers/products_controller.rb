class ProductsController < ApplicationController
  include BreadcrumbsHelper

  before_action :set_breadcrumbs
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/:id
  def show
    if @product&.category
      add_breadcrumb @product.category.name, category_path(@product.category)
    end
    add_breadcrumb @product.name
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /products/:id/edit
  def edit
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  private

  def set_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Products", products_path
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :current_price,
      :stock_quantity,
      :sku,
      :brand,
      :category_id,
      :on_sale,
      :image
    )
  end
end
