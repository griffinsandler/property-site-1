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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20171206030232) do
=======
<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20171207014148) do
=======
ActiveRecord::Schema.define(version: 20171207015214) do
>>>>>>> e6b42616596deb7adf2e86fc1ca51af0b7c910d0
>>>>>>> 20d60a19b71ea179e772de49ed4bf3af1b36d1b1

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "joinrequests", force: :cascade do |t|
    t.boolean  "resolved"
    t.integer  "tenant_id"
    t.integer  "property_id"
    t.integer  "manager_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "joinrequests", ["manager_id"], name: "index_joinrequests_on_manager_id", using: :btree
  add_index "joinrequests", ["property_id"], name: "index_joinrequests_on_property_id", using: :btree
  add_index "joinrequests", ["tenant_id"], name: "index_joinrequests_on_tenant_id", using: :btree

<<<<<<< HEAD
  create_table "landlords", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "office_address"
    t.string   "phone_number"
    t.string   "email"
    t.text     "notes"
    t.string   "password"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"

    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

=======
>>>>>>> 20d60a19b71ea179e772de49ed4bf3af1b36d1b1
  create_table "managers", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "email"
    t.string   "password"
    t.string   "phone_number"
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.decimal  "square_feet"
    t.integer  "max_num_tenants"
    t.integer  "curr_num_tenants"
    t.decimal  "monthly_rent"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "manager_id"
    t.integer  "rent"
  end

<<<<<<< HEAD
=======
  add_index "properties", ["manager_id"], name: "index_properties_on_manager_id", using: :btree

  create_table "rents", force: :cascade do |t|
    t.integer  "total"
    t.integer  "property_id"
    t.integer  "manager_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "due"
  end

  add_index "rents", ["manager_id"], name: "index_rents_on_manager_id", using: :btree
  add_index "rents", ["property_id"], name: "index_rents_on_property_id", using: :btree

  create_table "rents_tenants", id: false, force: :cascade do |t|
    t.integer "rent_id",   null: false
    t.integer "tenant_id", null: false
  end

  add_index "rents_tenants", ["rent_id", "tenant_id"], name: "index_rents_tenants_on_rent_id_and_tenant_id", using: :btree
  add_index "rents_tenants", ["tenant_id", "rent_id"], name: "index_rents_tenants_on_tenant_id_and_rent_id", using: :btree

>>>>>>> 20d60a19b71ea179e772de49ed4bf3af1b36d1b1
  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "room"
    t.string   "notes"
    t.integer  "tenant_id"
    t.integer  "property_id"
    t.integer  "manager_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "subject"
  end

  add_index "services", ["manager_id"], name: "index_services_on_manager_id", using: :btree
  add_index "services", ["property_id"], name: "index_services_on_property_id", using: :btree
  add_index "services", ["tenant_id"], name: "index_services_on_tenant_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "email"
    t.string   "password"
<<<<<<< HEAD
<<<<<<< HEAD
    t.string   "phone_number"
    t.integer  "property_id"
    t.string   "rent"
=======
=======
    t.integer  "property_id"
    t.integer  "true_id"
>>>>>>> 20d60a19b71ea179e772de49ed4bf3af1b36d1b1
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "rent"
>>>>>>> ef59d954c55139b9d780a8e51296360795c4c6e0
  end

end
