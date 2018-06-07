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

ActiveRecord::Schema.define(version: 20160215012455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "username",        limit: 25
    t.string   "email",                      default: "", null: false
    t.string   "password_digest"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "chapter_title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "chapter_number"
    t.integer  "questionamount"
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "username",               limit: 25
    t.string   "email",                             default: "",    null: false
    t.string   "password_digest"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "emailconfirmed",                    default: false
    t.boolean  "email_confirmed",                   default: false
    t.string   "confirm_token"
    t.boolean  "active",                            default: true
  end

  create_table "question_assets", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "bytes"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isanswer"
    t.integer  "chapter_id"
  end

  add_index "question_assets", ["chapter_id"], name: "index_question_assets_on_chapter_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "chapter_id"
    t.string   "question_desc"
    t.string   "correct_answer"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "active"
  end

  create_table "results", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "chapter_id"
    t.boolean  "ongoing",         default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "question_id"
    t.string   "student_answer"
    t.boolean  "isanswercorrect"
    t.integer  "score_id"
    t.integer  "asset_id"
  end

  add_index "results", ["asset_id"], name: "index_results_on_asset_id", using: :btree
  add_index "results", ["question_id"], name: "index_results_on_question_id", using: :btree
  add_index "results", ["score_id"], name: "index_results_on_score_id", using: :btree

  create_table "scores", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "results_id"
    t.integer  "questions_id"
    t.integer  "is_value"
    t.integer  "of_value"
    t.boolean  "ongoing",      default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "chapter_id"
    t.integer  "final_score"
  end

  add_index "scores", ["chapter_id"], name: "index_scores_on_chapter_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "student_id",    limit: 8,                null: false
    t.boolean  "active",                  default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "instructor_id"
  end

  add_index "students", ["instructor_id"], name: "index_students_on_instructor_id", using: :btree
  add_index "students", ["student_id"], name: "index_students_on_student_id", using: :btree

  add_foreign_key "question_assets", "chapters"
  add_foreign_key "results", "questions"
  add_foreign_key "results", "scores"
  add_foreign_key "scores", "students"
  add_foreign_key "students", "instructors"
end
