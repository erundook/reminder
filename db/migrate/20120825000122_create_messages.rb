class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.datetime :requested_time
      t.datetime :delivery_time
      t.string :state
      t.integer :raw_size
      t.text :provider_response
      t.text :error_log
      t.belongs_to :phone

      t.timestamps
    end
    add_index :messages, :phone_id
    add_index :messages, :requested_time
    add_index :messages, :state
  end
end
