class CreateJoinTablePhotoSubProduct < ActiveRecord::Migration
  def change
    create_join_table :photos, :sub_products do |t|
      t.index [:photo_id, :sub_product_id]
      t.index [:sub_product_id, :photo_id]
    end
  end
end
