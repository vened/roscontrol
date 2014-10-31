class Admin::ProductsController < Admin::AdminController
  before_action :signed_in_manager, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :find, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def index
    @products = Product.all
    @prod_delete = Product.find_by_name("Название продукта")
    if @prod_delete
      @prod_delete.destroy
    end
  end

  def show
  end

  def new
    @product = Product.new(:price => 0, :name => "Название продукта")
    @sub_prod = SubProduct.new(:name => "Декоративные элементы")
    @product.sub_products << @sub_prod
    if @product.save
      redirect_to edit_admin_product_url(@product)
    else
      render :json => {error: @product.errors}
    end
  end

  def edit
  end

  def find
    @categories = @product.category_ser
    @brands = @product.brand_ser
    @properties_values = @product.prop_val
    render :json => {
        product: @product,
        sub_products: @product.sub_products,
        product_categories: @product.categories,
        product_brands: @product.brands,
        categories: @categories,
        brands: @brands,
        properties: @properties_values
    }
  end


  def create
    @product = Product.new(product_params)
    if @product.save
      render :json => {success: @product}
    else
      render :json => {error: @product.errors}
    end
  end

  def update
    if @product.update(product_params)
      render :json => {success: @product}
    else
      render :json => {error: @product.errors}
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Товар успешно удален!' }
      format.json { head :no_content }
    end
  end

  def set_property
    @product = Product.find(params[:product_id])
    @property = Property.find(params[:property_id])
    @product.properties << @property
    @properties = Property.all - @product.properties
    render :json => {
        properties: @properties,
        product_properties: @product.properties
    }
  end

  def set_property_value
    @product = Product.find(params[:product_id])
    @property = Property.find(params[:property_id])
    @value = Value.find(params[:value_id])
    unless @product.properties.exists?(@property)
      @product.properties << @property
    end
    unless @product.values.exists?(@value)
      @product.values << @value
    else
      @product.values.delete(@value)
      if @product.values.where(property_id: @value.property_id).length == 0
        @product.properties.delete(@property)
      end
    end
    render :json => {
        properties: @product.prop_val
    }
  end

  def set_brand
    @product = Product.find(params[:product_id])
    @brand = Brand.find(params[:brand_id])
    unless @product.brands.exists?(@brand)
      @product.brands << @brand
    else
      @product.brands.delete(@brand)
    end
    render :json => {
        brands: @product.brand_ser
    }
  end

  def set_category
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    unless @product.categories.exists?(@category)
      @product.categories << @category
    else
      @product.categories.delete(@category)
    end
    render :json => {
        brands: @product.category_ser
    }
  end

  def sub_product_new
    @product = Product.find(params[:product_id])
    @sub_product = SubProduct.create()
    @product.sub_products << @sub_product
    render :json => @product.sub_products
  end

  def sub_product_update
    @product = Product.find(params[:product_id])
    @sub_product = SubProduct.find(params[:sub_product_id])
    @sub_product.update(:name => params[:name])
    render :json => @product.sub_products
  end

  def sub_product_destroy
    logger.debug params
    @product = Product.find(params[:product_id])
    @sub_product = SubProduct.find(params[:sub_product_id])
    @sub_product.destroy
    render :json => @product.sub_products
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :body, :price, :photo, :sale, :art, :article, :new, :property_id, :value_id, :brand_id, :category_id, :sub_product_id)
  end

end
