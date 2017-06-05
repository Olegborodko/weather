class Work < ApplicationRecord
  belongs_to :location
  has_and_belongs_to_many :users

  validates :location_id, uniqueness: true
end