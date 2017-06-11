class Location < ApplicationRecord
  has_many :works
  has_many :apis, through: :works

  validates :city, presence: true
  validates :country, presence: true
  validates :country_key, presence: true
end
