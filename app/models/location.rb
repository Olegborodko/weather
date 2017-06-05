class Location < ApplicationRecord

  validates :city, presence: true
  validates :country, presence: true
  validates :country_key, presence: true
end
