class ProductsController < ApplicationController

  def filters
    filters = []
    JSON.parse(params[:filters]).each do |f|
      filters.push f[1]
    end

    @products = Product.filter(filters.join(","))

    def prod_val(products, filters)
      @p = []
      if filters.length > 0
        f = filters.shift
        for product in products
          if product.values.exists?(f)
            @p.push product
          end
        end
        @p = @p.uniq
        prod_val(@p, filters)
      else
        return @p = products
      end
    end

    @products = prod_val(@products, filters)

    @res = []
    @products.each do |product|
      prod = {product: product, full_path: product.full_path, photo: product.photos.first.photo.thumb.url}
      @res.push prod
    end

    render :json => @res
  end

  def catalog
    @categories = Category.roots
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
