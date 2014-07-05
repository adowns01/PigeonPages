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
  current_user.books << Book.create(title: params[:book_title])
  redirect to '/'
end

get '/list' do
  @books = current_user.books
  erb :list_books
end