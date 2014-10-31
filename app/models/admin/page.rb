class Admin::Page < ActiveRecord::Base
  has_and_belongs_to_many :galleries
  # before_validation :update_path
  # before_update :update_path
  validates :name, length: {minimum: 1}
  validates :path, length: {minimum: 1}, uniqueness: true
  
  acts_as_nested_set
  include TheSortableTree::Scopes

  
  def save_custom
    self.path = self.path.gsub!(/\s/, "-")
    self.path = I18n.transliterate(self.path)
    self.save
  end
  

  protected
  def update_path
    self.path = self.path.gsub!(/^\//, '')
  end


end
