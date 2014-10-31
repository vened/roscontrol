class ProductsController < ApplicationController

  
  def index
    @categories = Category.roots
    render :json => @categories
  end

  def category
    @category = Category.find_by_path(params[:id])
    @categories = @category.children.pluck(:id) 
    @products = Product.includes(:categories, :photos).where(categories: {id: @categories}).page(params[:page])
    @properties = Property.all
  end

  def product
    @product = Product.includes(:categories, :photos, :values, :properties).find(params[:product_id])
    @properties = @product.properties.includes(:values)
    @values = @product.values
    @category = @product.categories.first
  end

  private
  def product_params
    params.require(:product).permit(:price, :title, :body, :filters, :product_id, :category_id, :gallery_id)
  end

end
