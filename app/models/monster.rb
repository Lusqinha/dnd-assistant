class Monster < ApplicationRecord
  self.inheritance_column = :_type_disabled

  validates :index, presence: true, uniqueness: true
  validates :name, presence: true
end
