

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
  current_user.books << Book.create(book_info)
  redirect to '/'
end

get '/list' do
  @books = current_user.books
  erb :list_books
end


# get '/book_info/:isbn' do
#   # erb :add_book
#   isbn = params[:isbn]
#   book = GR.book_by_isbn(isbn).to_json
#   @book = JSON.parse(book)
#   erb :book_info
# end

#----------- see data -----------

get '/data' do
  @num_books = current_user.books.count
  @num_pages = num_pages()
  erb :list_data
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