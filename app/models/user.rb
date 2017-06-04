class User < ApplicationRecord
  has_secure_token :rid
  has_many :json_requests
end
