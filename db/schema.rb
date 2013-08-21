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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 3) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address",    default: "", null: false
    t.string   "phone",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.date     "date"
    t.string   "po",         default: "", null: false
    t.string   "number"
    t.string   "memo",       default: "", null: false
    t.integer  "company_id"
    t.float    "total"
    t.float    "discount"
    t.float    "billed"
    t.float    "paid"
    t.date     "payday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "invoice_id"
    t.string   "description"
    t.float    "rate"
    t.float    "hours"
    t.float    "amount"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
