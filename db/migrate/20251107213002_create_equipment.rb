class CreateEquipment < ActiveRecord::Migration[8.0]
  def change
    create_table :equipment do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.jsonb :equipment_category
      t.string :gear_category
      t.jsonb :cost
      t.decimal :weight, precision: 10, scale: 2
      t.string :url
      t.text :desc, array: true, default: []
      t.string :tool_category
      t.string :vehicle_category
      t.integer :quantity

      # Weapon-specific fields
      t.string :weapon_category
      t.string :weapon_range
      t.string :category_range
      t.jsonb :damage
      t.jsonb :range
      t.jsonb :properties, default: []
      t.jsonb :two_handed_damage

      # Armor-specific fields
      t.string :armor_category
      t.jsonb :armor_class
      t.integer :str_minimum
      t.boolean :stealth_disadvantage

      # Container/Vehicle fields
      t.jsonb :contents, default: []
      t.jsonb :speed
      t.string :capacity
      t.jsonb :throw_range
      t.text :special, array: true, default: []

      t.timestamps

      t.index :index, unique: true
      t.index :name
      t.index :equipment_category, using: :gin
      t.index :gear_category
    end
  end
end
