

class Book < ActiveRecord::Base
  has_many :users_books
  has_many :users, through: :users_books
  # Remember to create a migration!


  def self.get_book_info(title)
    begin
      book = GR.book_by_title(title).to_json
    rescue Exception => e
      return 0
      @error = true
    end

    unless @error
      book = JSON.parse(book)

      book_info = {
        title: book["title"],
        author: self.author(book),
        publication_year: book["work"]["original_publication_year"].to_i,
        is_ebook: book["is_ebook"]=="true",
        image: book["image_url"],
        pages: book["num_pages"],
        author_gender: self.author_gender(book)
        # author_country: self.author_country(book)
      }


    end

  end

  def self.author(book)
    if book["authors"]["author"].is_a? (Array)
      return book["authors"]["author"][0]["name"]
    else
      return book["authors"]["author"]["name"]
    end
  end

  def self.author_gender(book)
    author_id = self.author_id(book)

    author = GR.author(author_id).to_json
    author =  JSON.parse(author)
    p author["gender"]
  end

  # def self.author_country(book)
  #   author_id = self.author_id(book)

  #   author = GR.author(author_id).to_json
  #   author =  JSON.parse(author)
  #   return nil if !author["hometown"]
  #   p author["hometown"].split(" ").last
  # end


  def self.author_id(book)
    if book["authors"]["author"].is_a? (Array)
      return book["authors"]["author"][0]["id"]
    else
      return  book["authors"]["author"]["id"]
    end
  end


end
