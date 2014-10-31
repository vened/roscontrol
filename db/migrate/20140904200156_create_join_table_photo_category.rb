class CreateJoinTablePhotoCategory < ActiveRecord::Migration
  def change
    create_join_table :photos, :categories do |t|
      t.index [:photo_id, :category_id]
      t.index [:category_id, :photo_id]
    end
  end
end