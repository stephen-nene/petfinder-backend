class User < ActiveRecord::Base
  has_many :pets, foreign_key: "owner_id"
end
