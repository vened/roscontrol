class CreateJoinTableGalleryPhoto < ActiveRecord::Migration
  def change
    create_join_table :galleries, :photos do |t|
      t.index [:gallery_id, :photo_id]
      t.index [:photo_id, :gallery_id]
    end
  end
end
