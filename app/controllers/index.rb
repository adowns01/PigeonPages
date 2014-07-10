

get '/' do
 erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end



post '/sessions' do
  # sign-in
  login
  redirect to '/'
end



delete '/sessions/:id' do
  # sign-out -- invoked
  session.clear
  redirect to '/'
end

#----------- USERS -----------


get '/users/new' do
  erb :sign_up
end



post '/users' do

  user_info = {
    name: params[:name],
    email: params[:email],
    password: params[:password]
  }

  @user = User.create(user_info)
  p @user

  if @user.invalid?
    session[:errors] = @user.errors
    session[:email] = params[:email]
    session[:name] = params[:name]
    redirect to '/users/new'
  end


  login
  redirect to '/'
end

#----------- add-book -----------

post '/add_book' do
  p book_info = Book.get_book_info(params[:book_title])
  new_book = Book.create(book_info)
  current_user.books << new_book
  redirect to '/book/' + new_book.id.to_s
end

get '/list' do
  @books = current_user.books
  erb :list_books
end


#----------- see data -----------

get '/data' do
  @num_books = current_user.books.count
  @num_pages = num_pages()
  @most_pages = longest_book();
  @fewest_pages = shortest_book();

  erb :list_data
end

get '/popular_authors' do
  content_type :json
  info = popular_authors();
  return info.to_json
end

get '/ebooks' do
  content_type :json
  info = e_book_data();
  return info.to_json
end

get '/publication_year' do
  content_type :json
  info = publication_year_data();
  p info
  return info.to_json
end

#---------- edit book info -------

get '/book/:id' do
  @book = Book.find(params[:id])
  erb :edit_book
end

post '/book/:id' do
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
  Book.find(params[:id]).destroy
  redirect to '/list'
end