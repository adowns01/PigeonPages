class AddAuthorCountry < ActiveRecord::Migration
  def change
    add_column :books, :author_country, :string
  end
end
