class Admin::PropertiesController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @properties = Property.all
    render :json => @properties
  end

  def show
    render :json => {property: @property, values: @property.values}
  end

  def new
    @page = Property.new
  end

  def edit
    render :json => @property
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      render :json => @property
    else
      render :json => @property.errors
    end
  end

  def update
    if @property.update(property_params)
      render :json => @property
    else
      render :json => @property.errors
    end
  end

  def destroy
    @property.destroy
    render :json => @property
  end

  def values
    @property = Property.find(params[:property_id])
    @property.add_value(params)
    render :json => {property: @property, values: @property.values}
  end

  def delete_value
    @value = Value.find(params[:id])
    @value.destroy
    @property = Property.find(params[:property_id])
    render :json => {property: @property, values: @property.values}
  end
  
  private
  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :style, :unit, :property_values => [:ids])
  end
end
