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

ActiveRecord::Schema.define(:version => 20130627235223) do

  create_table "flags", :force => true do |t|
    t.string   "twitter_handle", :null => false
    t.integer  "post_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.string   "twitter_handle"
    t.string   "type"
    t.integer  "story_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "twitter_id"
    t.datetime "tweeted_at"
    t.integer  "votes_count",               :default => 0
    t.string   "from_user_name"
    t.string   "twitter_profile_image_url"
    t.datetime "start_time"
  end

  add_index "posts", ["story_id"], :name => "index_posts_on_story_id"
  add_index "posts", ["tweeted_at"], :name => "index_posts_on_tweeted_at"
  add_index "posts", ["twitter_handle"], :name => "index_posts_on_twitter_handle"
  add_index "posts", ["twitter_id"], :name => "index_posts_on_twitter_id", :unique => true
  add_index "posts", ["type"], :name => "index_posts_on_type"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "story_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "tagging_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_handle"
    t.string   "uid"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "auth_credentials"
  end

  add_index "users", ["twitter_handle"], :name => "index_users_on_twitter_handle"
  add_index "users", ["uid"], :name => "index_users_on_uid"

  create_table "votes", :force => true do |t|
    t.string   "twitter_handle"
    t.integer  "value"
    t.integer  "post_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "votes", ["post_id"], :name => "index_votes_on_story_id"
  add_index "votes", ["twitter_handle", "post_id"], :name => "index_votes_on_twitter_handle_and_story_id", :unique => true
  add_index "votes", ["twitter_handle"], :name => "index_votes_on_twitter_handle"

end
