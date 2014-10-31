class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :sortable
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :path
      t.string :photo
    end
    add_index :categories, :sortable
    add_index :categories, :parent_id
    add_index :categories, :lft
    add_index :categories, :rgt
    add_index :categories, :path
  end
end
