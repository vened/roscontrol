class Page < ActiveRecord::Base
  has_and_belongs_to_many :galleries
  
  acts_as_nested_set
  include TheSortableTree::Scopes


  def to_param
    "#{path}"
  end

end
