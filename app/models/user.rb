class User < ActiveRecord::Base

  attr_accessible :username, :password, :password_confirmation, :role
  attr_accessor :password
  attr_accessor :password_confirmation

  validates_presence_of :username, :message => 'Please enter User Name.'
  validates_uniqueness_of :username, :message => 'User Name already exists.'

  before_save :encrypt_password

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
