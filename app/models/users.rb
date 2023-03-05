class User < ActiveRecord::Base
  has_many :pets, foreign_key: "owner_id"

  # retrieve password from hash
  def password
    @password ||= Password.new(password_hash)
  end

  # create the password hash
  def password=(new_pass)
    @password = Password.create(new_pass)
    self.password_hash = @password
  end

  # authenticate user
  def self.authenticate(username, password)
    user = find_by(username: username)
    if user && Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end
end
