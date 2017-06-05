class User < ApplicationRecord
  has_secure_token :rid
  has_and_belongs_to_many :works

end
