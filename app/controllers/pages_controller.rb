class PagesController < ApplicationController

  def index
    @categories = Category.roots
  end

  def show
    @page = Page.includes(:galleries).find_by_path(params[:id])
  end

  def carousel
    @carousel = Gallery.includes(:photos).find_by_slider(true)
    @photos = @carousel.photos
    render json: @photos
  end

end
