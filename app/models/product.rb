class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :photos
  has_and_belongs_to_many :properties
  has_and_belongs_to_many :values
  has_and_belongs_to_many :brands
  has_many :sub_products

  paginates_per 20


  # scope :filter, -> (value_id){ joins(:values).group("id"){ where(id: value_id)} }

  scope :filter, -> (value_id) { joins(:values).where('values.id = ?', value_id) }

  validates :price, :numericality => true
  validates :name, presence: true


  def prop_val
    @product_properties = []
    Property.all.each do |property|
      property_values = []
      property.values.each do |value|
        unless self.values.exists?(value)
          property_value = {id: value.id, value: value.value, checked: 0}
          property_values.push property_value
        else
          property_value = {id: value.id, value: value.value, checked: 1}
          property_values.push property_value
        end
      end
      product_property = {id: property.id, name: property.name, values: property_values}
      @product_properties.push product_property
    end
    return @product_properties
  end

  def brand_ser
    @product_brands = []
    Brand.all.each do |brand|
      unless self.brands.exists?(brand)
        brand = {id: brand.id, name: brand.name, checked: 0}
      else
        brand = {id: brand.id, name: brand.name, checked: 1}
      end
      @product_brands.push brand
    end
    return @product_brands
  end

  def category_ser
    @product_categories = []
    Category.all.each do |category|
      unless self.categories.exists?(category)
        category = {id: category.id, name: category.name, checked: 0}
      else
        category = {id: category.id, name: category.name, checked: 1}
      end
      @product_categories.push category
    end
    return @product_categories
  end
  
  def full_path
    self.categories.first.front_full_path + '/product/' + self.id.to_s
  end

end
