class Work < ApplicationRecord
  belongs_to :location
  belongs_to :api
  has_and_belongs_to_many :users

  validates :location_id, presence: true
  validates :api_id, presence: true
end