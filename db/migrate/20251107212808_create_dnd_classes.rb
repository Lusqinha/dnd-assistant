class CreateDndClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :dnd_classes do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.integer :hit_die, null: false
      t.jsonb :proficiency_choices, default: []
      t.jsonb :proficiencies, default: []
      t.jsonb :saving_throws, default: []
      t.jsonb :starting_equipment
      t.jsonb :class_levels
      t.jsonb :subclasses, default: []
      t.string :url
      t.jsonb :spellcasting

      t.timestamps

      t.index :index, unique: true
      t.index :name
    end
  end
end
