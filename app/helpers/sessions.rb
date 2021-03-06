helpers do
  # This will return the current user, if they exist
  # Replace with code that works with your application
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
    else
      session[:email] = params[:email]
      session[:errors] = "wrong username and/or password"
    end
  end

  def your_book?(id)
    return !current_user.books.where('book_id = ?', id).empty?
  end

end