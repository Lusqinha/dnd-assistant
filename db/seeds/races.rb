require 'csv'
require 'json'

# Helper method to safely evaluate Python-like strings to Ruby objects
def safe_eval_field(field)
  return nil if field.nil? || field.empty?

  begin
    eval(field)
  rescue
    nil
  end
end

puts "🧝 Seeding D&D Races..."

csv_path = Rails.root.join('lib', 'datasets', 'races.csv')

Race.delete_all

CSV.foreach(csv_path, headers: true) do |row|
  # Parse fields using safe_eval
  ability_bonuses = safe_eval_field(row['ability_bonuses']) || []
  starting_proficiencies = safe_eval_field(row['starting_proficiencies']) || []
  languages = safe_eval_field(row['languages']) || []
  traits = safe_eval_field(row['traits']) || []
  trait_options = safe_eval_field(row['trait_options'])
  subraces = safe_eval_field(row['subraces']) || []
  starting_proficiency_options = safe_eval_field(row['starting_proficiency_options'])
  ability_bonus_options = safe_eval_field(row['ability_bonus_options'])
  language_options = safe_eval_field(row['language_options'])

  Race.create!(
    index: row['index'],
    name: row['name'],
    speed: row['speed'].to_i,
    ability_bonuses: ability_bonuses,
    alignment: row['alignment'],
    age: row['age'],
    size: row['size'],
    size_description: row['size_description'],
    starting_proficiencies: starting_proficiencies,
    languages: languages,
    language_desc: row['language_desc'],
    traits: traits,
    trait_options: trait_options,
    subraces: subraces,
    url: row['url'],
    starting_proficiency_options: starting_proficiency_options,
    ability_bonus_options: ability_bonus_options,
    language_options: language_options
  )

  print '.'
end

puts "\n✅ Created #{Race.count} D&D races!"
