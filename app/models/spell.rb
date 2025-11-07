class Spell < ApplicationRecord
  validates :index, presence: true, uniqueness: true
  validates :name, presence: true
  validates :level, presence: true
end
