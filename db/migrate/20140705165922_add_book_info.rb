class AddBookInfo < ActiveRecord::Migration
  def change
    add_column :books, :author, :string
    add_column :books, :publication_year, :integer
    add_column :books, :image, :string
    add_column :books, :is_ebook, :boolean
  end
end
