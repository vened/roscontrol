class CreateJoinTableProductProperty < ActiveRecord::Migration
  def change
    create_join_table :products, :properties do |t|
      t.index [:product_id, :property_id]
      t.index [:property_id, :product_id]
    end
  end
end
