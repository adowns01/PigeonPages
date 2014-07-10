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

