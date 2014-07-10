class User < ActiveRecord::Base
  has_many :users_books
  has_many :books, through: :users_books




  include BCrypt
  validates :name, :email, :password, presence: true
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates :email, :format => /.+@.+\..+/
  before_save :encrypt_password

  def encrypt_password
    # puts "self.pass #{self.password}"
    # puts "password #{password}"
    # # self.password = password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def books
  #   return "Write me please"
  # end



end
