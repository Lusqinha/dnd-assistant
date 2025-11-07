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

puts "✨ Seeding D&D Spells..."

csv_path = Rails.root.join('lib', 'datasets', 'spells.csv')
Spell.delete_all

CSV.foreach(csv_path, headers: true) do |row|
  begin
    desc = safe_eval_field(row['desc']) || []
    desc = [ desc ] unless desc.is_a?(Array)

    higher_level = safe_eval_field(row['higher_level']) || []
    higher_level = [ higher_level ] unless higher_level.is_a?(Array)

    components = safe_eval_field(row['components']) || []
    components = [ components ] unless components.is_a?(Array)

    damage = safe_eval_field(row['damage'])
    school = safe_eval_field(row['school']) || {}
    classes = safe_eval_field(row['classes']) || []
    subclasses = safe_eval_field(row['subclasses']) || []
    dc = safe_eval_field(row['dc'])
    heal_at_slot_level = safe_eval_field(row['heal_at_slot_level'])
    area_of_effect = safe_eval_field(row['area_of_effect'])

    Spell.create!(
      index: row['index'],
      name: row['name'],
      desc: desc,
      higher_level: higher_level,
      range: row['range'],
      components: components,
      material: row['material'],
      ritual: row['ritual'] == 'True',
      duration: row['duration'],
      concentration: row['concentration'] == 'True',
      casting_time: row['casting_time'],
      level: row['level'].to_i,
      attack_type: row['attack_type'],
      damage: damage,
      school: school,
      classes: classes,
      subclasses: subclasses,
      url: row['url'],
      dc: dc,
      heal_at_slot_level: heal_at_slot_level,
      area_of_effect: area_of_effect
    )
    print '.'
  rescue => e
    puts "\n⚠️ Error processing #{row['name']}: #{e.message}"
  end
end

puts "\n✅ Created #{Spell.count} spells!"
