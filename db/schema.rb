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

ActiveRecord::Schema.define(:version => 20110827095127) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "floors", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guests", :force => true do |t|
    t.string   "FirstName"
    t.string   "LastName"
    t.integer  "age"
    t.string   "photo"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.date     "bbirthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "category_id"
    t.integer  "sell_price"
    t.string   "image"
    t.text     "pattribute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "r_tables", :force => true do |t|
    t.integer  "floor_id"
    t.integer  "x_position"
    t.integer  "y_position"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_lines", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "product_id"
    t.float    "sell_price"
    t.integer  "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "r_table_id"
    t.integer  "guest_id"
    t.string   "status"
    t.integer  "waiter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

end
