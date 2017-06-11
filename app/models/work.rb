class Work < ApplicationRecord
  belongs_to :location
  belongs_to :api
  has_and_belongs_to_many :users

end