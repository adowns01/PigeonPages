#----------- add-book -----------

post '/add_book' do
  redirect to('/error') if !current_user

  book_info = Book.get_book_info(params[:book_title])

  if book_info == 0
    session[:error] = "Sorry we could not find that book."
    redirect '/'
  end

  new_book = Book.create(book_info)
  current_user.books << new_book
  redirect to '/book/' + new_book.id.to_s
end

get '/list' do
  redirect to('/error') if !current_user

  @books = current_user.books.reverse
  erb :list_books
end


#---------- edit book info -------

get '/book/:id' do
  redirect to('/error') if !current_user

  @book = Book.find(params[:id])
  erb :edit_book
end

post '/book/:id' do
  redirect to('/error') if !current_user

  book_info = {
    title: params[:title],
    author: params[:author],
    publication_year: params[:publication_year],
    pages: params[:num_pages],
    is_ebook: params[:ebook] == "true"
  }

  book = Book.find(params[:id])
  book.update_attributes(book_info)
  redirect to '/list'
end

post '/delete/:id' do
  redirect to('/error') if !current_user

  Book.find(params[:id]).destroy
  redirect to '/list'
end