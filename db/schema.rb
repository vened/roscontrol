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

ActiveRecord::Schema.define(version: 20141020045202) do

  create_table "brands", force: true do |t|
    t.string  "name"
    t.text    "body"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string  "path"
  end

  add_index "brands", ["lft"], name: "index_brands_on_lft", using: :btree
  add_index "brands", ["parent_id"], name: "index_brands_on_parent_id", using: :btree
  add_index "brands", ["path"], name: "index_brands_on_path", using: :btree
  add_index "brands", ["rgt"], name: "index_brands_on_rgt", using: :btree

  create_table "brands_photos", id: false, force: true do |t|
    t.integer "brand_id", null: false
    t.integer "photo_id", null: false
  end

  add_index "brands_photos", ["brand_id", "photo_id"], name: "index_brands_photos_on_brand_id_and_photo_id", using: :btree
  add_index "brands_photos", ["photo_id", "brand_id"], name: "index_brands_photos_on_photo_id_and_brand_id", using: :btree

  create_table "brands_products", id: false, force: true do |t|
    t.integer "brand_id",   null: false
    t.integer "product_id", null: false
  end

  add_index "brands_products", ["brand_id", "product_id"], name: "index_brands_products_on_brand_id_and_product_id", using: :btree
  add_index "brands_products", ["product_id", "brand_id"], name: "index_brands_products_on_product_id_and_brand_id", using: :btree

  create_table "categories", force: true do |t|
    t.string  "name"
    t.integer "sortable"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string  "path"
    t.text    "body"
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["path"], name: "index_categories_on_path", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree
  add_index "categories", ["sortable"], name: "index_categories_on_sortable", using: :btree

  create_table "categories_photos", id: false, force: true do |t|
    t.integer "photo_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "categories_photos", ["category_id", "photo_id"], name: "index_categories_photos_on_category_id_and_photo_id", using: :btree
  add_index "categories_photos", ["photo_id", "category_id"], name: "index_categories_photos_on_photo_id_and_category_id", using: :btree

  create_table "categories_products", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "product_id",  null: false
  end

  add_index "categories_products", ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id", using: :btree
  add_index "categories_products", ["product_id", "category_id"], name: "index_categories_products_on_product_id_and_category_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text   "message"
  end

  create_table "galleries", force: true do |t|
    t.string  "name"
    t.string  "system_name"
    t.text    "body"
    t.boolean "slider"
  end

  create_table "galleries_pages", id: false, force: true do |t|
    t.integer "gallery_id", null: false
    t.integer "page_id",    null: false
  end

  add_index "galleries_pages", ["gallery_id", "page_id"], name: "index_galleries_pages_on_gallery_id_and_page_id", using: :btree
  add_index "galleries_pages", ["page_id", "gallery_id"], name: "index_galleries_pages_on_page_id_and_gallery_id", using: :btree

  create_table "galleries_photos", id: false, force: true do |t|
    t.integer "gallery_id", null: false
    t.integer "photo_id",   null: false
  end

  add_index "galleries_photos", ["gallery_id", "photo_id"], name: "index_galleries_photos_on_gallery_id_and_photo_id", using: :btree
  add_index "galleries_photos", ["photo_id", "gallery_id"], name: "index_galleries_photos_on_photo_id_and_gallery_id", using: :btree

  create_table "managers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["name"], name: "index_managers_on_name", using: :btree
  add_index "managers", ["remember_token"], name: "index_managers_on_remember_token", using: :btree

  create_table "news", force: true do |t|
    t.string   "path"
    t.string   "name"
    t.text     "body"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string  "name"
    t.text    "body"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string  "path"
    t.boolean "feedback"
    t.boolean "menu",      default: true
  end

  add_index "pages", ["lft"], name: "index_pages_on_lft", using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["path"], name: "index_pages_on_path", using: :btree
  add_index "pages", ["rgt"], name: "index_pages_on_rgt", using: :btree

  create_table "photos", force: true do |t|
    t.string  "photo"
    t.string  "name"
    t.text    "body"
    t.boolean "root"
  end

  create_table "photos_products", id: false, force: true do |t|
    t.integer "photo_id",   null: false
    t.integer "product_id", null: false
  end

  add_index "photos_products", ["photo_id", "product_id"], name: "index_photos_products_on_photo_id_and_product_id", using: :btree
  add_index "photos_products", ["product_id", "photo_id"], name: "index_photos_products_on_product_id_and_photo_id", using: :btree

  create_table "photos_sub_products", id: false, force: true do |t|
    t.integer "photo_id",       null: false
    t.integer "sub_product_id", null: false
  end

  add_index "photos_sub_products", ["photo_id", "sub_product_id"], name: "index_photos_sub_products_on_photo_id_and_sub_product_id", using: :btree
  add_index "photos_sub_products", ["sub_product_id", "photo_id"], name: "index_photos_sub_products_on_sub_product_id_and_photo_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "article"
    t.string   "name"
    t.text     "body"
    t.decimal  "price",      precision: 10, scale: 0
    t.integer  "sale"
    t.string   "art"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new"
  end

  add_index "products", ["price"], name: "index_products_on_price", using: :btree
  add_index "products", ["sale"], name: "index_products_on_sale", using: :btree

  create_table "products_properties", id: false, force: true do |t|
    t.integer "product_id",  null: false
    t.integer "property_id", null: false
  end

  add_index "products_properties", ["product_id", "property_id"], name: "index_products_properties_on_product_id_and_property_id", using: :btree
  add_index "products_properties", ["property_id", "product_id"], name: "index_products_properties_on_property_id_and_product_id", using: :btree

  create_table "products_values", id: false, force: true do |t|
    t.integer "product_id", null: false
    t.integer "value_id",   null: false
  end

  add_index "products_values", ["product_id", "value_id"], name: "index_products_values_on_product_id_and_value_id", using: :btree
  add_index "products_values", ["value_id", "product_id"], name: "index_products_values_on_value_id_and_product_id", using: :btree

  create_table "properties", force: true do |t|
    t.string  "name"
    t.string  "style"
    t.string  "unit"
    t.integer "sortable"
  end

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "sub_products", force: true do |t|
    t.string  "name"
    t.text    "body"
    t.integer "product_id"
  end

  create_table "values", force: true do |t|
    t.integer "property_id"
    t.string  "value"
  end

  add_index "values", ["property_id"], name: "index_values_on_property_id", using: :btree
  add_index "values", ["value"], name: "index_values_on_value", using: :btree

end
