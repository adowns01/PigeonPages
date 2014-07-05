class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users
 # users.password_hash in the database is a :string
  include BCrypt
  validates :name, :email, :password, presence: true
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates :email, :format => /.+@.+\..+/
  before_save :encrypt_password

  def encrypt_password
    puts "self.pass #{self.password}"
    puts "password #{password}"
    # self.password = password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end




end
