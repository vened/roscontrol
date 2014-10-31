class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :path
      t.string :name
      t.text :body
      t.boolean :public
      t.timestamps
    end
  end
end
