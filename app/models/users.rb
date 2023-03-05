class User < ActiveRecord::Base
  validates :username, :email, :password_hash, presence: true
  validates :email, uniqueness: true

end
