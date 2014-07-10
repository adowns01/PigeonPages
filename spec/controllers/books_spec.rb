require 'spec_helper'

$user_info = { name: "Amelia", email: "sample@example.com", password: "password"}
$book_info = { title: "Harry Potter", author: "JK Rowling", pages: "750"}


describe "Book Controller" do
  context "GET  /list" do
    it "displays all of the users books" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/list', {}, fake_session
      expect(last_response.body).to include(book.title)
    end

    it "doesn't display other users books" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)

      fake_session = {'rack.session' => {user_id: user.id}}

      get '/list', {}, fake_session
      expect(last_response.body).to_not include(book.title)
    end
  end

  context "GET /book/:id" do
    it "displays the title of the book" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get "/book/#{book.id}", {}, fake_session
      expect(last_response.body).to include(book.title)
    end

    it "displays the author of the book" do
      Book.delete_all
      User.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_session = {'rack.session' => {user_id: user.id}}

      get "/book/#{book.id}", {}, fake_session
      expect(last_response.body).to include(book.author)
    end
  end

  context "POST '/add_book" do
    it "adds a valid book to the user" do
      User.delete_all
      Book.delete_all

      user = User.create($user_info)
      fake_params = {book_title: "Where the Wild Things Are"}
      fake_session = {'rack.session' => {user_id: user.id}}

      post '/add_book', fake_params, fake_session

      expect(user.books.length).to eq(1)
    end
    it "doesn't add a invalid book to the user" do
      User.delete_all
      Book.delete_all

      user = User.create($user_info)
      fake_params = {book_title: "---"}
      fake_session = {'rack.session' => {user_id: user.id}}

      post '/add_book', fake_params, fake_session

      expect(user.books.length).to eq(0)
    end
  end

  context "POST /book/:id" do
    it "updates the books attributes" do
      User.delete_all
      Book.delete_all

      user = User.create($user_info)
      book = Book.create($book_info)
      user.books << book

      fake_params = {title: "TEST",
        author: "TEST",
        publication_year: 2000,
        num_pages: 100,
        ebook: false,
        id: book.id}
        fake_session = {'rack.session' => {user_id: user.id}}

        post "book/#{book.id}", fake_params, fake_session

        expect(Book.find(book.id).title).to eq("TEST")
      end
    end

    context "POST /delete/:id" do
      it "deletes the book from the db" do
        User.delete_all
        Book.delete_all

        user = User.create($user_info)
        book = Book.create($book_info)
        user.books << book

        fake_session = {'rack.session' => {user_id: user.id}}

        post "delete/#{book.id}", {}, fake_session

        expect{Book.find(book.id)}.to raise_exception
        end
      end
    end
