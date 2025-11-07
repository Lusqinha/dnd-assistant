# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🎲 Starting D&D Database Seeding...\n"

# Load all seed files in order
load Rails.root.join('db', 'seeds', 'dnd_classes.rb')
load Rails.root.join('db', 'seeds', 'races.rb')
load Rails.root.join('db', 'seeds', 'equipment.rb')
load Rails.root.join('db', 'seeds', 'monsters.rb')
load Rails.root.join('db', 'seeds', 'spells.rb')

puts "\n🎉 D&D Database seeding completed!"
puts "📊 Summary:"
puts "   - #{DndClass.count} classes"
puts "   - #{Race.count} races"
puts "   - #{Equipment.count} equipment items"
puts "   - #{Monster.count} monsters"
puts "   - #{Spell.count} spells"
