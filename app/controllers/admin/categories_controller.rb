class Admin::CategoriesController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_item, only: [:show, :find, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  include TheSortableTreeController::Rebuild


  def index
    @categories = Admin::Category.all.order('lft ASC')
    @clear_nill_category = Admin::Category.find_by_name("название")
    if @clear_nill_category
      @clear_nill_category.destroy
    end
  end

  def show
  end

  def new
    # @category = Admin::Category.new
    @category = Admin::Category.new(
        :path => "введите url", :name => "название"
    )
    @category.save validate: false
    @categories = Admin::Category.all
  end

  def edit
    @categories = Admin::Category.all
  end

  def find
    @category_translation = Admin::Category.find(params[:id])
    render :json => @category_translation
  end

  def update
    if @category.update(category_params)
      render :json => {success: @category}
    else
      render :json => {error: @category.errors}
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Категория успешно удалена!' }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @category = Admin::Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:sortable, :parent_id, :path, :name, :body, :photo)
  end
end
