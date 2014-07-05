class UsersBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  # Remember to create a migration!
end
