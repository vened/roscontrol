class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
    end
  end
end
