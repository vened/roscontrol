class Admin::Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :photos


  validates :name, length: {minimum: 1}, uniqueness: true
  validates :path, length: {minimum: 1}, uniqueness: true


  acts_as_nested_set
  include TheSortableTree::Scopes


  def full_path
    @parents = self.self_and_ancestors.select(:path)
    @path = @parents.map do |p|
      "/" + p.path
    end
    @path.join()
  end


end
