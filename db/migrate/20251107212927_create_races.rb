class CreateRaces < ActiveRecord::Migration[8.0]
  def change
    create_table :races do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.integer :speed, null: false
      t.jsonb :ability_bonuses, default: []
      t.text :alignment
      t.text :age
      t.string :size
      t.text :size_description
      t.jsonb :starting_proficiencies, default: []
      t.jsonb :languages, default: []
      t.text :language_desc
      t.jsonb :traits, default: []
      t.jsonb :trait_options
      t.jsonb :subraces, default: []
      t.string :url
      t.jsonb :starting_proficiency_options
      t.jsonb :ability_bonus_options
      t.jsonb :language_options

      t.timestamps

      t.index :index, unique: true
      t.index :name
    end
  end
end
