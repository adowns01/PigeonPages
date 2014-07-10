require 'spec_helper'

describe "Book model" do
  it "gets data from a valid book title" do
    Book.delete_all
    book_data = Book.get_book_info("Where the Wild Things Are")
    new_book = Book.create(book_data)
    expect(new_book.valid?).to eq(true)
  end

  it "returns correct error for invalid book title" do
    Book.delete_all
    book_data = Book.get_book_info("-----")
    expect(book_data).to eq(0)
  end
  it "gets data from a valid book isbn" do
    Book.delete_all
    book_data = Book.get_book_info("978-1250030955")
    new_book = Book.create(book_data)
    expect(new_book.valid?).to eq(true)
  end
  it "returns correct error for invalid book isbn" do
    Book.delete_all
    book_data = Book.get_book_info("000-00000000000")
    expect(book_data).to eq(0)
  end
end
