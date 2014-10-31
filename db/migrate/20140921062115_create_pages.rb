class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :body
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth # this is optional.
      t.string :path
      t.boolean :feedback
      t.boolean :menu, default: true 
    end
    add_index :pages, :parent_id
    add_index :pages, :lft
    add_index :pages, :rgt
    add_index :pages, :path
  end
end
