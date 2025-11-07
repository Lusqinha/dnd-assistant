# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_07_213343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "dnd_classes", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.integer "hit_die", null: false
    t.jsonb "proficiency_choices", default: []
    t.jsonb "proficiencies", default: []
    t.jsonb "saving_throws", default: []
    t.jsonb "starting_equipment"
    t.jsonb "class_levels"
    t.jsonb "subclasses", default: []
    t.string "url"
    t.jsonb "spellcasting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_dnd_classes_on_index", unique: true
    t.index ["name"], name: "index_dnd_classes_on_name"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.jsonb "equipment_category"
    t.string "gear_category"
    t.jsonb "cost"
    t.decimal "weight", precision: 10, scale: 2
    t.string "url"
    t.text "desc", default: [], array: true
    t.string "tool_category"
    t.string "vehicle_category"
    t.integer "quantity"
    t.string "weapon_category"
    t.string "weapon_range"
    t.string "category_range"
    t.jsonb "damage"
    t.jsonb "range"
    t.jsonb "properties", default: []
    t.jsonb "two_handed_damage"
    t.string "armor_category"
    t.jsonb "armor_class"
    t.integer "str_minimum"
    t.boolean "stealth_disadvantage"
    t.jsonb "contents", default: []
    t.jsonb "speed"
    t.string "capacity"
    t.jsonb "throw_range"
    t.text "special", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_category"], name: "index_equipment_on_equipment_category", using: :gin
    t.index ["gear_category"], name: "index_equipment_on_gear_category"
    t.index ["index"], name: "index_equipment_on_index", unique: true
    t.index ["name"], name: "index_equipment_on_name"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.string "size"
    t.string "type"
    t.string "subtype"
    t.string "alignment"
    t.integer "armor_class"
    t.integer "hit_points"
    t.string "hit_dice"
    t.jsonb "speed"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.jsonb "proficiencies", default: []
    t.text "damage_vulnerabilities", default: [], array: true
    t.text "damage_resistances", default: [], array: true
    t.text "damage_immunities", default: [], array: true
    t.text "condition_immunities", default: [], array: true
    t.jsonb "senses"
    t.string "languages"
    t.decimal "challenge_rating", precision: 10, scale: 2
    t.jsonb "special_abilities", default: []
    t.jsonb "actions", default: []
    t.jsonb "legendary_actions", default: []
    t.jsonb "reactions", default: []
    t.string "url"
    t.jsonb "other_speeds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_rating"], name: "index_monsters_on_challenge_rating"
    t.index ["index"], name: "index_monsters_on_index", unique: true
    t.index ["name"], name: "index_monsters_on_name"
    t.index ["type"], name: "index_monsters_on_type"
  end

  create_table "races", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.integer "speed", null: false
    t.jsonb "ability_bonuses", default: []
    t.text "alignment"
    t.text "age"
    t.string "size"
    t.text "size_description"
    t.jsonb "starting_proficiencies", default: []
    t.jsonb "languages", default: []
    t.text "language_desc"
    t.jsonb "traits", default: []
    t.jsonb "trait_options"
    t.jsonb "subraces", default: []
    t.string "url"
    t.jsonb "starting_proficiency_options"
    t.jsonb "ability_bonus_options"
    t.jsonb "language_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_races_on_index", unique: true
    t.index ["name"], name: "index_races_on_name"
  end

  create_table "spells", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.text "desc", default: [], array: true
    t.text "higher_level", default: [], array: true
    t.string "range"
    t.text "components", default: [], array: true
    t.text "material"
    t.boolean "ritual", default: false
    t.string "duration"
    t.boolean "concentration", default: false
    t.string "casting_time"
    t.integer "level", null: false
    t.string "attack_type"
    t.jsonb "damage"
    t.jsonb "school"
    t.jsonb "classes", default: []
    t.jsonb "subclasses", default: []
    t.string "url"
    t.jsonb "dc"
    t.jsonb "heal_at_slot_level"
    t.jsonb "area_of_effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_spells_on_index", unique: true
    t.index ["level"], name: "index_spells_on_level"
    t.index ["name"], name: "index_spells_on_name"
    t.index ["school"], name: "index_spells_on_school", using: :gin
  end
end
