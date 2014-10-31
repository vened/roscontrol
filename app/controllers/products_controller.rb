class ProductsController < ApplicationController

  
  def index
    @categories = Category.roots
    render :json => @categories
  end

  def category
    @category = Category.find(params[:id])
    @categories = @category.children
    render :json => {category: @category, categories: @categories}
  end

  def products
    @category = Category.find(params[:id])
    @products = @category.products
    render :json => {category: @category, products: @products}
  end

  def product
    @product = Product.find(params[:id])
    render :json => @product
  end

  private
  def product_params
    params.require(:product).permit(:price, :title, :body, :filters, :product_id, :category_id, :gallery_id)
  end

end
