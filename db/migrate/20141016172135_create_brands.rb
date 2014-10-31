class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.text :body
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :path
    end
    add_index :brands, :parent_id
    add_index :brands, :lft
    add_index :brands, :rgt
    add_index :brands, :path
  end
end
