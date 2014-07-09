GR = Goodreads::Client.new(:api_key => "knKbRPZ09o4ZQoez2KGg", :api_secret => "zbAuN1PwKTxf6gOBop9hy8QS7R0atdPfEPisq9X6iM")


class Book < ActiveRecord::Base
  has_many :users_books
  has_many :users, through: :users_books
  # Remember to create a migration!


  def self.get_book_info(title)



    book = GR.book_by_title(title).to_json
    book = JSON.parse(book)

    book_info = {
      title: book["title"],
      author: self.author(book),
      publication_year: book["work"]["original_publication_year"].to_i,
      is_ebook: book["is_ebook"]=="true",
      image: book["image_url"],
      pages: book["num_pages"]
    }
    return book_info

  end

  def self.author(book)
    if book["authors"]["author"].is_a? (Array)
      return book["authors"]["author"][0]["name"]
    else
      return book["authors"]["author"]["name"]
    end
  end

end
