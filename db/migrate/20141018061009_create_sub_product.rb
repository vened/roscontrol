class CreateSubProduct < ActiveRecord::Migration
  def change
    create_table :sub_products do |t|
      t.string :name
      t.text :body
      t.references :product
    end
  end
end
