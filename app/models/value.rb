class Value < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :property
  validates :value, length: {minimum: 1}
end
