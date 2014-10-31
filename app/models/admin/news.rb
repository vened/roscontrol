class Admin::News < ActiveRecord::Base
  validates :name, length: {minimum: 1}
end
