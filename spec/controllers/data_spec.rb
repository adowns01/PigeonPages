require 'spec_helper'

$user_info = { name: "Amelia", email: "sample@example.com", password: "password"}
$book_info = { title: "Harry Potter", author: "JK Rowling", pages: 750, publication_year: 1998}
$book_info_short = { title: "Harry Potter", author: "JK Rowling", pages: 10}
$book_info_early = { title: "Harry Potter", author: "JK Rowling", pages: 10, publication_year: 1942}



describe "Book Controller" do
  context "GET  /data" do
    it "lists the number of books" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/data', {}, fake_session
      expect(last_response.body).to include("Total books<br>1")
    end
    it "lists the number of pages" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/data', {}, fake_session
      expect(last_response.body).to include("Total pages<br>#{book.pages}")
    end
    it "lists the most pages" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/data', {}, fake_session
      expect(last_response.body).to include("#{book.pages} pages")
    end
    it "lists the fewest pages" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      book_short = Book.create($book_info_short)
      user.books << book
      user.books << book_short

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/data', {}, fake_session
      expect(last_response.body).to include("#{book_short.pages} pages")

    end
  end
  context "GET /popular_authors" do
    it "returns an nested array of the most popular authors and num of books read" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/popular_authors', {}, fake_session
      expect(last_response.body).to eq([[book.author, 1]].to_json)

    end
  end
  context "GET /ebooks" do
    it "returns a hash with number of ebook/paper books" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/ebooks', {}, fake_session
      expect(last_response.body).to eq({"ebook" => 0, "paper" => 1}.to_json)
    end
  end
  context "GET /publication_year" do
    it "returns an array with each decade from the first book pub year to last" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      book_early = Book.create($book_info_early)
      user.books << book
      user.books << book_early

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/publication_year', {}, fake_session

      years = JSON.parse(last_response.body)
      expected_len = ((book.publication_year-book_early.publication_year)%10)
      expect(years.length).to eq(expected_len)
    end

    it "the array of data has the right y values" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/publication_year', {}, fake_session

      years = JSON.parse(last_response.body)
      expect(years[0][1]).to eq(1)
    end
  end
end
