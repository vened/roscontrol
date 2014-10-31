class Admin::PagesController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_pages, only: [:index, :all, :new, :edit]
  skip_before_action :verify_authenticity_token
  include TheSortableTreeController::Rebuild

  def index
  end

  def all
    render :json => @pages
  end

  def show
  end

  def new
    @page = Admin::Page.new
  end

  def edit
  end

  def create
    @page = Admin::Page.new(page_params)
    if @page.save
      render :json => {success: @page}
    else
      render :json => {error: @page.errors}
    end
  end

  def update
    if @page.update(page_params)
      render :json => {success: @page}
    else
      render :json => {error: @page.errors}
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: 'Страница успешно удалена' }
      format.json { head :no_content }
    end
  end

  def find
    @page = Admin::Page.find(params[:id])
    render :json => @page
  end

  private
  def set_page
    @page = Admin::Page.find(params[:id])
  end

  def set_pages
    @pages = Admin::Page.all.order('lft ASC')
    @categories = Admin::Category.all.order('lft ASC')
  end

  def page_params
    params.require(:page).permit(:path, :parent_id, :name, :body, :feedback, :menu)
  end
end
