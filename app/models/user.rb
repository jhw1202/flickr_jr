require 'bcrypt'
class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :albums
  has_many :photos

  before_create :hash_password

  def hash_password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
