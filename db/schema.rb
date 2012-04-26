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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120426025626) do

  create_table "stories", :force => true do |t|
    t.text     "content"
    t.string   "twitter_handle"
    t.integer  "story_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "stories", ["created_at"], :name => "index_stories_on_created_at"
  add_index "stories", ["story_id"], :name => "index_stories_on_story_id"
  add_index "stories", ["twitter_handle"], :name => "index_stories_on_twitter_handle"

end
