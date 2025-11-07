class CreateSpells < ActiveRecord::Migration[8.0]
  def change
    create_table :spells do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.text :desc, array: true, default: []
      t.text :higher_level, array: true, default: []
      t.string :range
      t.text :components, array: true, default: []
      t.text :material
      t.boolean :ritual, default: false
      t.string :duration
      t.boolean :concentration, default: false
      t.string :casting_time
      t.integer :level, null: false
      t.string :attack_type
      t.jsonb :damage
      t.jsonb :school
      t.jsonb :classes, default: []
      t.jsonb :subclasses, default: []
      t.string :url
      t.jsonb :dc
      t.jsonb :heal_at_slot_level
      t.jsonb :area_of_effect

      t.timestamps

      t.index :index, unique: true
      t.index :name
      t.index :level
      t.index :school, using: :gin
    end
  end
end
