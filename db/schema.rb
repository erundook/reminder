# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120826103214) do

  create_table "messages", :force => true do |t|
    t.string   "text"
    t.datetime "requested_time"
    t.datetime "delivery_time"
    t.string   "state"
    t.integer  "raw_size"
    t.text     "provider_response"
    t.text     "error_log"
    t.integer  "phone_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "messages", ["phone_id"], :name => "index_messages_on_phone_id"
  add_index "messages", ["requested_time"], :name => "index_messages_on_requested_time"
  add_index "messages", ["state"], :name => "index_messages_on_state"

  create_table "phones", :force => true do |t|
    t.string   "number"
    t.integer  "paid_messages", :default => 3
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "verified"
  end

  add_index "phones", ["number"], :name => "index_phones_on_number"

end
