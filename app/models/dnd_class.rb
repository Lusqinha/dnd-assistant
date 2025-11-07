class DndClass < ApplicationRecord
  validates :index, presence: true, uniqueness: true
  validates :name, presence: true
  validates :hit_die, presence: true
end
