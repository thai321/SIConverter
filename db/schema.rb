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

ActiveRecord::Schema.define(version: 20171226231258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "si_name_symbols", force: :cascade do |t|
    t.string "name"
    t.string "symbol", null: false
    t.string "si_type", null: false
    t.integer "si_unit_id", null: false
    t.index ["name"], name: "index_si_name_symbols_on_name", unique: true
    t.index ["si_unit_id"], name: "index_si_name_symbols_on_si_unit_id", unique: true
    t.index ["symbol"], name: "index_si_name_symbols_on_symbol", unique: true
  end

  create_table "si_units", force: :cascade do |t|
    t.string "unit", null: false
    t.float "factor", null: false
    t.index ["factor"], name: "index_si_units_on_factor"
    t.index ["unit"], name: "index_si_units_on_unit"
  end

end
