class Race < ApplicationRecord
  validates :index, presence: true, uniqueness: true
  validates :name, presence: true
  validates :speed, presence: true
end
