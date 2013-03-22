require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :albums
  has_many :photos
  
  validates :email, :format => {:with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, :message => "Not Valid"}
  validates :password, :presence => true
  validates :name, :presence => true

  before_create :hash_password

  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end

  def self.authenticate(email, entered_password)
    user = User.find_by_email(email)
    if BCrypt::Password.new(user.password) == entered_password
      return user
    end
  end


end
