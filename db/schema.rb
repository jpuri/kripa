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

ActiveRecord::Schema.define(:version => 20130329104843) do

  create_table "bill_parts", :force => true do |t|
    t.integer  "bill_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "discount"
    t.float    "weight"
    t.float    "price"
    t.integer  "part_id"
  end

  create_table "bills", :force => true do |t|
    t.date     "bill_date"
    t.integer  "customer_id"
    t.integer  "currency_id"
    t.string   "status"
    t.float    "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_weight"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "customer_id"
    t.string   "country"
    t.string   "fax"
    t.string   "web"
  end

  create_table "model_parts", :force => true do |t|
    t.integer  "model_id"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_prices", :force => true do |t|
    t.integer  "currency_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "part_id"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "number"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
