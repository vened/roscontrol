class Brand < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :photos

  acts_as_nested_set
  include TheSortableTree::Scopes

  def to_param
    "#{path}"
  end

  def front_full_path
    @parents = self.self_and_ancestors.select(:path)
    @path = ["/brands"]
    @path += @parents.map do |p|
      "/" + p.path
    end
    @path.join()
  end
end
