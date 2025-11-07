class CreateMonsters < ActiveRecord::Migration[8.0]
  def change
    create_table :monsters do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.string :size
      t.string :type
      t.string :subtype
      t.string :alignment
      t.integer :armor_class
      t.integer :hit_points
      t.string :hit_dice
      t.jsonb :speed

      # Ability scores
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      # Skills and resistances
      t.jsonb :proficiencies, default: []
      t.text :damage_vulnerabilities, array: true, default: []
      t.text :damage_resistances, array: true, default: []
      t.text :damage_immunities, array: true, default: []
      t.text :condition_immunities, array: true, default: []
      t.jsonb :senses
      t.string :languages
      t.decimal :challenge_rating, precision: 10, scale: 2

      # Complex abilities
      t.jsonb :special_abilities, default: []
      t.jsonb :actions, default: []
      t.jsonb :legendary_actions, default: []
      t.jsonb :reactions, default: []
      t.string :url
      t.jsonb :other_speeds

      t.timestamps

      t.index :index, unique: true
      t.index :name
      t.index :type
      t.index :challenge_rating
    end
  end
end
