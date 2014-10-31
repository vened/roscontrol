class Admin::PhotosController < Admin::AdminController
  skip_before_action :verify_authenticity_token

  def upload
    @photo = Photo.new(:photo => params[:photo])
    @product = Product.find(params[:product_id])
    @photo.products << @product
    if @photo.save
      render :json => @photo
    else
      render :json => {error: true}
    end
  end

  def find
    @product = Product.find(params[:product_id])
    @photos = @product.photos
    render :json => @photos
  end

  def upload_category
    @photo = Photo.new(:photo => params[:photo])
    @category = Admin::Category.find(params[:category_id])
    @category.photos << @photo
    if @photo.save
      render :json => @photo
    else
      render :json => {error: true}
    end
  end

  def find_sub_product
    @sub_product = SubProduct.find(params[:sub_product_id])
    @photos = @sub_product.photos
    render :json => @photos
  end

  def upload_sub_product
    @photo = Photo.new(:photo => params[:photo])
    @sub_product = SubProduct.find(params[:sub_product_id])
    @sub_product.photos << @photo
    if @photo.save
      render :json => @photo
    else
      render :json => {error: true}
    end
  end

  def find_category
    @category = Admin::Category.find(params[:category_id])
    @photos = @category.photos
    render :json => @photos
  end

  def upload_brand
    @photo = Photo.new(:photo => params[:photo])
    @brand = Admin::Brand.find(params[:brand_id])
    @brand.photos << @photo
    if @photo.save
      render :json => @photo
    else
      render :json => {error: true}
    end
  end

  def find_brand
    @brand = Admin::Brand.find(params[:brand_id])
    @photos = @brand.photos
    render :json => @photos
  end

  def upload_gallery
    @photo = Photo.new(:photo => params[:photo])
    @gallery = Gallery.find(params[:gallery_id])
    @gallery.photos << @photo
    if @photo.save
      render :json => @photo
    else
      render :json => {error: true}
    end
  end

  def find_gallery
    @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos
    render :json => @photos
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      render :json => @photo
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      render :json => @photo
    end
  end

  private
  def photo_params
    # params.require(:offer).permit!
    params.require(:photo).permit(:photo, :root, :name, :body)
    # params.require(:photo).permit(:photo, :root, :name, :body, :product_id => [:ids])
    # params.require(:user).permit( :attribute_translations => [:id => [:name, :city, :includes, :notes, :description, :slug]])
    # :attribute_translations => [:id => [:name, :city, :includes, :notes, :description, :slug]]
  end
end
