class AddAuthorGender < ActiveRecord::Migration
  def change
    add_column :books, :author_gender, :string
  end
end
