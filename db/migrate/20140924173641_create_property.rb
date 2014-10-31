class CreateProperty < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :style
      t.string :unit
      t.integer :sortable
    end
  end
end
