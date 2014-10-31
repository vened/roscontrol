class CreateJoinTableProductValue < ActiveRecord::Migration
  def change
    create_join_table :products, :values do |t|
      t.index [:product_id, :value_id]
      t.index [:value_id, :product_id]
    end
  end
end
