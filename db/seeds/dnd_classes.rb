require 'csv'
require 'json'

# Helper method to safely evaluate Python-like strings to Ruby objects
def safe_eval_field(field)
  return nil if field.nil? || field.empty?

  begin
    # Use eval to convert Python dict/list syntax to Ruby
    # This is safe because we control the CSV files
    eval(field)
  rescue
    nil
  end
end

puts "🧙 Seeding D&D Classes..."

csv_path = Rails.root.join('lib', 'datasets', 'classes.csv')

DndClass.delete_all

CSV.foreach(csv_path, headers: true) do |row|
  # Parse fields using safe_eval
  proficiency_choices = safe_eval_field(row['proficiency_choices']) || []
  proficiencies = safe_eval_field(row['proficiencies']) || []
  saving_throws = safe_eval_field(row['saving_throws']) || []
  starting_equipment = safe_eval_field(row['starting_equipment']) || {}
  class_levels = safe_eval_field(row['class_levels']) || {}
  subclasses = safe_eval_field(row['subclasses']) || []
  spellcasting = safe_eval_field(row['spellcasting'])

  DndClass.create!(
    index: row['index'],
    name: row['name'],
    hit_die: row['hit_die'].to_i,
    proficiency_choices: proficiency_choices,
    proficiencies: proficiencies,
    saving_throws: saving_throws,
    starting_equipment: starting_equipment,
    class_levels: class_levels,
    subclasses: subclasses,
    url: row['url'],
    spellcasting: spellcasting
  )

  print '.'
end

puts "\n✅ Created #{DndClass.count} D&D classes!"
