class Api < ApplicationRecord
  has_many :works
  has_many :locations, through: :works

  validates :category, presence: true
end
