class Property < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_many :values, dependent: :delete_all

  validates :name, length: {minimum: 1}

  def add_value(params)
    @value = params[:property][:property_values]
    @value = Value.new(value: @value)
    self.values << @value
  end
  
end
