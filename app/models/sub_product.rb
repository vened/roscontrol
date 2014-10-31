class SubProduct < ActiveRecord::Base
  has_and_belongs_to_many :photos
  belongs_to :product
end
