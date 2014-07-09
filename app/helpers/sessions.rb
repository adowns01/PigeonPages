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

  def num_pages
    pages = 0

    current_user.books.each do |book|
      if book.pages.is_a?(Integer)
        pages += book.pages
      end
    end

    return pages
  end

  def e_book_data

    book_info = {
      ebook: 0,
      paper: 0
    }

    current_user.books.each do |book|
      if book.is_ebook
        book_info[:ebook] += 1
      else
        book_info[:paper] += 1
      end
    end
    return book_info
  end

  def publication_year_data

    current_user.books.map! do |book|
      book.publication_year
    end
  end

  def longest_book()
    return current_user.books.maximum('pages')
  end

  def shortest_book()
    return current_user.books.minimum('pages')
  end

  def popular_authors()
    authors = current_user.books.group(:author).count
    return authors.sort_by {|k,v| v}.reverse[0..4]
  end




end