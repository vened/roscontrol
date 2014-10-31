class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.belongs_to :property, index: true
      t.string :value
    end
    add_index :values, :value
  end
end
