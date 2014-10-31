class Admin::GalleriesController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @galleries = Gallery.includes(:photos, :pages).all
    if Gallery.find_by_name("название")
      @gallery = Gallery.find_by_name("название")
      @gallery.destroy
    end
    @obj = []
    @galleries.each do |gallery|
      @obj.push gallery.attributes.merge({photos: gallery.photos.last(2), page: gallery.pages.last(1)})
    end
    render :json => @obj
  end

  def show
  end

  def new
    if Gallery.find_by_name("название")
      @gallery = Gallery.find_by_name("название")
    else
      @gallery = Gallery.new(:name => "название")
      @gallery.save
    end
    render :json => @gallery
  end

  def edit
    render :json => @gallery
  end

  def update
    if params[:page_id]
      @page = Admin::Page.find(params[:page_id])
      @page.galleries << @gallery
    end
    if @gallery.update(gallery_params)
      render :json => @gallery
    else
      render :json => {error: @gallery.errors}
    end
  end

  def destroy
    @gallery.destroy
    render :json => @gallery
  end

  private
  def set_item
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :system_name, :body, :slider, :photos, :page_id)
  end
end
