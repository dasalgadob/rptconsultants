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

ActiveRecord::Schema.define(version: 20190418175707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "grupo_id"
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grupo_id"], name: "index_accounts_on_grupo_id", using: :btree
  end

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_areas_on_company_id", using: :btree
  end

  create_table "auxiliars", force: :cascade do |t|
    t.integer  "subaccount_id"
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "number_text"
    t.index ["subaccount_id"], name: "index_auxiliars_on_subaccount_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "clases", force: :cascade do |t|
    t.integer  "number",     null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cost_centres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "criteria", force: :cascade do |t|
    t.string   "criteria_type"
    t.integer  "score"
    t.integer  "degree_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "description"
    t.integer  "position_type_id"
    t.integer  "criteria_type_id"
    t.index ["degree_id"], name: "index_criteria_on_degree_id", using: :btree
    t.index ["position_type_id"], name: "index_criteria_on_position_type_id", using: :btree
  end

  create_table "criteria_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.integer  "number"
    t.integer  "minimum"
    t.integer  "median"
    t.integer  "maximun"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "hay"
    t.integer  "ggs"
  end

  create_table "document_types", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "code"
  end

  create_table "grupos", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.integer  "clase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clase_id"], name: "index_grupos_on_clase_id", using: :btree
  end

  create_table "historics", force: :cascade do |t|
    t.string   "clase"
    t.integer  "user_id"
    t.integer  "valuation_id"
    t.string   "previous_fields"
    t.string   "new_fields"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_historics_on_user_id", using: :btree
    t.index ["valuation_id"], name: "index_historics_on_valuation_id", using: :btree
  end

  create_table "invoice_services", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "service_id"
    t.string   "description"
    t.decimal  "value"
    t.decimal  "iva"
    t.decimal  "withholding_tax"
    t.decimal  "withholding_tax_ica"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["invoice_id"], name: "index_invoice_services_on_invoice_id", using: :btree
    t.index ["service_id"], name: "index_invoice_services_on_service_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "comments"
    t.decimal  "total",      precision: 15, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["person_id"], name: "index_invoices_on_person_id", using: :btree
  end

  create_table "job_titles", force: :cascade do |t|
    t.string   "name"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.index ["area_id"], name: "index_job_titles_on_area_id", using: :btree
    t.index ["company_id"], name: "index_job_titles_on_company_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "city_id"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_locations_on_city_id", using: :btree
    t.index ["person_id"], name: "index_locations_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.integer  "document_type_id"
    t.bigint   "document_number"
    t.integer  "verification_digit"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "surname"
    t.string   "second_surname"
    t.string   "business_name"
    t.string   "email"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "is_withholding_agent"
    t.index ["document_type_id"], name: "index_people_on_document_type_id", using: :btree
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "number_type"
    t.bigint   "number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["person_id"], name: "index_phone_numbers_on_person_id", using: :btree
  end

  create_table "position_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "minimum_degree"
    t.integer  "maximum_degree"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "degree_id"
    t.integer  "position_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "abbreviation"
    t.index ["degree_id"], name: "index_roles_on_degree_id", using: :btree
    t.index ["position_type_id"], name: "index_roles_on_position_type_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.integer  "auxiliar_id"
    t.integer  "cost_centre_id"
    t.integer  "taxable_income"
    t.integer  "account_IVA_id"
    t.integer  "account_withholding_tax_id"
    t.integer  "account_withholding_tax_ICA_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["account_IVA_id"], name: "index_services_on_account_IVA_id", using: :btree
    t.index ["account_withholding_tax_ICA_id"], name: "index_services_on_account_withholding_tax_ICA_id", using: :btree
    t.index ["account_withholding_tax_id"], name: "index_services_on_account_withholding_tax_id", using: :btree
    t.index ["auxiliar_id"], name: "index_services_on_auxiliar_id", using: :btree
    t.index ["cost_centre_id"], name: "index_services_on_cost_centre_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
  end

  create_table "subaccounts", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_subaccounts_on_account_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "person_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
    t.boolean  "is_admin"
    t.integer  "company_id"
    t.boolean  "evaluate"
    t.boolean  "review"
    t.boolean  "approve"
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
    t.index ["person_id"], name: "index_users_on_person_id", using: :btree
  end

  create_table "valuations", force: :cascade do |t|
    t.integer  "job_title_id"
    t.integer  "position_type_id"
    t.integer  "knowledge_id"
    t.integer  "skill_id"
    t.integer  "definition_supervision_id"
    t.integer  "risk_decision_id"
    t.integer  "sustainability_id"
    t.integer  "area_impact_id"
    t.integer  "influence_id"
    t.integer  "score"
    t.integer  "degree_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "company_id"
    t.boolean  "review"
    t.boolean  "approve"
    t.index ["area_impact_id"], name: "index_valuations_on_area_impact_id", using: :btree
    t.index ["company_id"], name: "index_valuations_on_company_id", using: :btree
    t.index ["definition_supervision_id"], name: "index_valuations_on_definition_supervision_id", using: :btree
    t.index ["degree_id"], name: "index_valuations_on_degree_id", using: :btree
    t.index ["influence_id"], name: "index_valuations_on_influence_id", using: :btree
    t.index ["job_title_id"], name: "index_valuations_on_job_title_id", using: :btree
    t.index ["knowledge_id"], name: "index_valuations_on_knowledge_id", using: :btree
    t.index ["position_type_id"], name: "index_valuations_on_position_type_id", using: :btree
    t.index ["risk_decision_id"], name: "index_valuations_on_risk_decision_id", using: :btree
    t.index ["skill_id"], name: "index_valuations_on_skill_id", using: :btree
    t.index ["sustainability_id"], name: "index_valuations_on_sustainability_id", using: :btree
  end

  create_table "withholding_tax_locations", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_withholding_tax_locations_on_city_id", using: :btree
    t.index ["person_id"], name: "index_withholding_tax_locations_on_person_id", using: :btree
  end

  add_foreign_key "accounts", "grupos"
  add_foreign_key "areas", "companies"
  add_foreign_key "auxiliars", "subaccounts"
  add_foreign_key "cities", "states"
  add_foreign_key "criteria", "criteria_types"
  add_foreign_key "criteria", "degrees"
  add_foreign_key "criteria", "position_types"
  add_foreign_key "grupos", "clases"
  add_foreign_key "historics", "users"
  add_foreign_key "historics", "valuations"
  add_foreign_key "invoice_services", "invoices"
  add_foreign_key "invoice_services", "services"
  add_foreign_key "invoices", "people"
  add_foreign_key "job_titles", "areas"
  add_foreign_key "job_titles", "companies"
  add_foreign_key "locations", "cities"
  add_foreign_key "locations", "people"
  add_foreign_key "people", "document_types"
  add_foreign_key "phone_numbers", "people"
  add_foreign_key "roles", "degrees"
  add_foreign_key "roles", "position_types"
  add_foreign_key "services", "auxiliars"
  add_foreign_key "services", "auxiliars", column: "account_IVA_id"
  add_foreign_key "services", "auxiliars", column: "account_withholding_tax_ICA_id"
  add_foreign_key "services", "auxiliars", column: "account_withholding_tax_id"
  add_foreign_key "services", "cost_centres"
  add_foreign_key "states", "countries"
  add_foreign_key "subaccounts", "accounts"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "people"
  add_foreign_key "valuations", "companies"
  add_foreign_key "valuations", "criteria", column: "area_impact_id"
  add_foreign_key "valuations", "criteria", column: "definition_supervision_id"
  add_foreign_key "valuations", "criteria", column: "influence_id"
  add_foreign_key "valuations", "criteria", column: "knowledge_id"
  add_foreign_key "valuations", "criteria", column: "risk_decision_id"
  add_foreign_key "valuations", "criteria", column: "skill_id"
  add_foreign_key "valuations", "criteria", column: "sustainability_id"
  add_foreign_key "valuations", "degrees"
  add_foreign_key "valuations", "job_titles"
  add_foreign_key "valuations", "position_types"
  add_foreign_key "withholding_tax_locations", "cities"
  add_foreign_key "withholding_tax_locations", "people"
end
