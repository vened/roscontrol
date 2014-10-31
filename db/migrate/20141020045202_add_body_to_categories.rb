class AddBodyToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :body, :text
  end
end
