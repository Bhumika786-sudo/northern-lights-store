class CategoriesController < ApplicationController
  include BreadcrumbsHelper

  before_action :set_breadcrumbs
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    add_breadcrumb @category.name
  end

  private

  def set_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Categories", categories_path
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
