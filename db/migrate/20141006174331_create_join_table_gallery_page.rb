class CreateJoinTableGalleryPage < ActiveRecord::Migration
  def change
    create_join_table :galleries, :pages do |t|
      t.index [:gallery_id, :page_id]
      t.index [:page_id, :gallery_id]
    end
  end
end
