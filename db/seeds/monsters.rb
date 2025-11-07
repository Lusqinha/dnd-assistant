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

puts "🐉 Seeding D&D Monsters..."

csv_path = Rails.root.join('lib', 'datasets', 'monsters.csv')
Monster.delete_all

CSV.foreach(csv_path, headers: true) do |row|
  begin
    speed = safe_eval_field(row['speed']) || {}
    proficiencies = safe_eval_field(row['proficiencies']) || []
    damage_vulnerabilities = safe_eval_field(row['damage_vulnerabilities']) || []
    damage_resistances = safe_eval_field(row['damage_resistances']) || []
    damage_immunities = safe_eval_field(row['damage_immunities']) || []
    condition_immunities = safe_eval_field(row['condition_immunities']) || []
    senses = safe_eval_field(row['senses']) || {}
    special_abilities = safe_eval_field(row['special_abilities']) || []
    actions = safe_eval_field(row['actions']) || []
    legendary_actions = safe_eval_field(row['legendary_actions']) || []
    reactions = safe_eval_field(row['reactions']) || []
    other_speeds = safe_eval_field(row['other_speeds'])

    Monster.create!(
      index: row['index'],
      name: row['name'],
      size: row['size'],
      type: row['type'],
      subtype: row['subtype'],
      alignment: row['alignment'],
      armor_class: row['armor_class'],
      hit_points: row['hit_points'],
      hit_dice: row['hit_dice'],
      speed: speed,
      strength: row['strength'],
      dexterity: row['dexterity'],
      constitution: row['constitution'],
      intelligence: row['intelligence'],
      wisdom: row['wisdom'],
      charisma: row['charisma'],
      proficiencies: proficiencies,
      damage_vulnerabilities: damage_vulnerabilities,
      damage_resistances: damage_resistances,
      damage_immunities: damage_immunities,
      condition_immunities: condition_immunities,
      senses: senses,
      languages: row['languages'],
      challenge_rating: row['challenge_rating'],
      special_abilities: special_abilities,
      actions: actions,
      legendary_actions: legendary_actions,
      reactions: reactions,
      url: row['url'],
      other_speeds: other_speeds
    )
    print '.'
  rescue => e
    puts "\n⚠️ Error processing #{row['name']}: #{e.message}"
  end
end

puts "\n✅ Created #{Monster.count} monsters!"
