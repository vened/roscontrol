class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :body
      t.decimal :price
      t.integer :sale
      t.string :rate
      t.text :property
      t.text :test
      t.string :photo

      t.timestamps
    end
    add_index :products, :price
    add_index :products, :sale
  end
end