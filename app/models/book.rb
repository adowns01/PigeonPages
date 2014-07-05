class Book < ActiveRecord::Base
  has_many :users_books
  has_many :users, through: :users_books
  # Remember to create a migration!
end
