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

ActiveRecord::Schema.define(:version => 20110618200821) do

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions_pronouncements", :id => false, :force => true do |t|
    t.integer "pronouncement_id"
    t.integer "commission_id"
  end

  create_table "gazettes", :force => true do |t|
    t.string   "serial"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pronouncements", :force => true do |t|
    t.text     "details"
    t.integer  "gazette_id"
    t.string   "url_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", :force => true do |t|
    t.string   "state"
    t.string   "voted_where"
    t.datetime "voted_at"
    t.integer  "pronouncement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
