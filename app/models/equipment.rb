class Equipment < ApplicationRecord
  validates :index, presence: true, uniqueness: true
  validates :name, presence: true
end
