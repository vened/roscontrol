class CreateGallery < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :system_name
      t.text :body
      t.boolean :slider
    end
  end
end
