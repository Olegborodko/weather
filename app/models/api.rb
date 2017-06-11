class Api < ApplicationRecord
  has_many :works
  has_many :locations, through: :works

end
