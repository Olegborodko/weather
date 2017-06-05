class User < ApplicationRecord
  has_secure_token :rid
  has_many :works


end
