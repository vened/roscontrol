class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo
      t.string :name
      t.text :body
      t.boolean :root
    end
  end
end
