require 'csv'

# Helper method to safely evaluate Python-like strings to Ruby objects
def safe_eval_field(field)
  return nil if field.nil? || field.empty?
  begin
    eval(field)
  rescue
    nil
  end
end

puts "⚔️ Seeding D&D Equipment..."

csv_path = Rails.root.join('lib', 'datasets', 'equipment.csv')
Equipment.delete_all

CSV.foreach(csv_path, headers: true) do |row|
  begin
    equipment_category = safe_eval_field(row['equipment_category'])
    cost = safe_eval_field(row['cost'])
    desc = safe_eval_field(row['desc']) || []
    desc = [ desc ] unless desc.is_a?(Array)

    damage = safe_eval_field(row['damage'])
    range = safe_eval_field(row['range'])
    properties = safe_eval_field(row['properties']) || []
    two_handed_damage = safe_eval_field(row['2h_damage'])
    armor_class = safe_eval_field(row['armor_class'])
    contents = safe_eval_field(row['contents']) || []
    speed = safe_eval_field(row['speed'])
    throw_range = safe_eval_field(row['throw_range'])
    special = safe_eval_field(row['special']) || []
    special = [ special ] unless special.is_a?(Array)

    Equipment.create!(
      index: row['index'],
      name: row['name'],
      equipment_category: equipment_category,
      gear_category: row['gear_category'],
      cost: cost,
      weight: row['weight'],
      url: row['url'],
      desc: desc,
      tool_category: row['tool_category'],
      vehicle_category: row['vehicle_category'],
      quantity: row['quantity'],
      weapon_category: row['weapon_category'],
      weapon_range: row['weapon_range'],
      category_range: row['category_range'],
      damage: damage,
      range: range,
      properties: properties,
      two_handed_damage: two_handed_damage,
      armor_category: row['armor_category'],
      armor_class: armor_class,
      str_minimum: row['str_minimum'],
      stealth_disadvantage: row['stealth_disadvantage'] == 'True',
      contents: contents,
      speed: speed,
      capacity: row['capacity'],
      throw_range: throw_range,
      special: special
    )
    print '.'
  rescue => e
    puts "\n⚠️ Error processing #{row['name']}: #{e.message}"
  end
end

puts "\n✅ Created #{Equipment.count} equipment items!"
