class Gallery < ActiveRecord::Base
  has_and_belongs_to_many :photos
  has_and_belongs_to_many :pages

  validates :name, length: {minimum: 1}, uniqueness: true
end
