class Admin::BrandsController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_item, only: [:show, :find, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  include TheSortableTreeController::Rebuild


  def index
    @brands = Admin::Brand.all.order('lft ASC')
    @clear_nill_brand = Admin::Brand.find_by_name("название")
    if @clear_nill_brand
      @clear_nill_brand.destroy
    end
  end

  def show
  end

  def new
    @brand = Admin::Brand.new(
        :name => "название"
    )
    if @brand.save validate: false
      redirect_to edit_admin_brand_url(@brand)
    else
      render :json => {error: @brand.errors}
    end
    # @brands = Admin::Brand.all
  end

  def edit
    @brands = Admin::Brand.all
  end

  def find
    @brand_translation = Admin::Brand.find(params[:id])
    render :json => @brand_translation
  end

  def update
    if @brand.update(brand_params)
      render :json => {success: @brand}
    else
      render :json => {error: @brand.errors}
    end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_brands_url, notice: 'Бренд успешно удален!' }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @brand = Admin::Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:sortable, :parent_id, :path, :name, :body)
  end
end
