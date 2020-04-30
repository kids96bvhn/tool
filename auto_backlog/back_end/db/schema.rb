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

ActiveRecord::Schema.define(version: 0) do

  create_table "fdoc_t_ticket", primary_key: ["tik_i_id", "tik_i_pro_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tik_i_id", null: false
    t.integer "tik_i_pro_id", null: false
    t.integer "tik_i_trac_id"
    t.integer "tik_i_status"
    t.string "tik_v_field_summary", limit: 256
    t.string "tik_v_field_summary_jp", limit: 256
    t.string "tik_v_field_reporter", limit: 256
    t.text "tik_t_field_description"
    t.text "tik_t_field_description_jp"
    t.integer "tik_i_field_type"
    t.integer "tik_i_field_milestone"
    t.integer "tik_i_field_component"
    t.integer "tik_i_field_severity"
    t.string "tik_v_field_keywords", limit: 256
    t.string "tik_v_field_cc", limit: 256
    t.string "tik_v_field_site", limit: 256
    t.datetime "tik_dt_field_delivery"
    t.datetime "tik_dt_field_release"
    t.integer "tik_i_inid"
    t.datetime "tik_dt_indt"
    t.integer "tik_i_upid"
    t.datetime "tik_dt_updt"
    t.integer "tik_i_del_flg"
    t.integer "tik_i_mail_magazine_flg"
    t.text "tik_t_field_input"
    t.text "tik_t_field_output"
    t.text "tik_t_field_output_release"
    t.string "tik_v_field_plan_duration", limit: 256
    t.datetime "tik_dt_field_plan_start"
    t.datetime "tik_dt_field_plan_end"
    t.string "tik_v_field_real_duration", limit: 256
    t.datetime "tik_dt_field_real_start"
    t.datetime "tik_dt_field_real_end"
    t.text "tik_t_field_note"
    t.integer "tik_i_assign"
    t.integer "tik_i_approve_flg", default: 0
    t.index ["tik_i_del_flg"], name: "index_tik_i_del_flg"
    t.index ["tik_i_mail_magazine_flg"], name: "index_tik_i_mail_magazine_flg"
    t.index ["tik_i_pro_id"], name: "index_pro_id"
    t.index ["tik_i_status"], name: "index_tik_i_status"
    t.index ["tik_i_trac_id"], name: "index_tik_i_trac_id"
  end

  create_table "fdoc_t_ticket_field_milestone", primary_key: "tik_field_milestone_i_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tik_field_milestone_i_pro_id", null: false
    t.string "tik_field_milestone_v_name", limit: 256
    t.integer "tik_field_milestone_i_default"
    t.integer "tik_field_milestone_i_order", default: 0
    t.integer "tik_field_milestone_i_delivery"
    t.integer "tik_field_milestone_i_ticket_status"
    t.string "tik_field_milestone_v_name_jp", limit: 256
  end

end
