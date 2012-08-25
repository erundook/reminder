class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :paid_messages, default: 3
      t.timestamps
    end
    add_index :phones, :number
  end
end
