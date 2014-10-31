class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :managers, :email, unique: true
    add_index :managers, :name
    add_index :managers, :remember_token
  end
end
