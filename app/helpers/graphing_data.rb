helpers do
  def author_gender
    data = [["male", 0],["female",0]]
    books = current_user.books
    books.each do |book|
      if book.author_gender == "male"
        data[0][1] += 1
      elsif book.author_gender == "female"
        data[1][1] += 1
      end
    end
    return data
  end






  # gets total number of pages the user has read
  def num_pages
    total_pages = 0
    current_user.books.each do |book|
      if book.pages.is_a?(Integer)
        total_pages += book.pages
      end
    end
    return total_pages
  end

  # gets ebook data and parses it for highcharts
  def e_book_data
    book_info = { ebook: 0, paper: 0 }

    current_user.books.each do |book|
      if book.is_ebook
        book_info[:ebook] += 1
      else
        book_info[:paper] += 1
      end
    end
    return book_info
  end

  def add_pub_year_data(pub_years, pub_year_data_container, min_decade)
    pub_years.each do |year|
      location = (year % min_decade)/10
      pub_year_data_container[location][1] += 1
    end
    return pub_year_data_container
  end

  def set_up_data_structure(min_decade, max_decade)
    data = []
    (((max_decade-min_decade)/10)+1).times do |i|
      decade = (min_decade + i*10).to_s
      data << ["#{decade}s", 0]
    end
    return data
  end

  def get_publication_years
    pub_years = current_user.books.map do |book|
      book.publication_year
    end
    pub_years.delete(nil)

    return pub_years
  end

  def get_smallest_decade(pub_years)
    (pub_years.min/10)*10
  end

  def get_largest_decade(pub_years)
    (pub_years.max/10)*10
  end

  def publication_year_data

    pub_years = get_publication_years

    min_decade = get_smallest_decade(pub_years)
    max_decade = get_largest_decade(pub_years)

    pub_year_data_container = set_up_data_structure(min_decade, max_decade)
    data = add_pub_year_data(pub_years, pub_year_data_container, min_decade)
    return data

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

  def num_pages_graph()
    num_pages = current_user.books.map do |book|
      book.pages
    end
    num_pages.delete(nil)

    max_pages = (num_pages.max/100)*100
    p num_pages
    p max_pages

    data_container = []
    ((max_pages/100)+1).times do |i|
      data_container << ["#{i*100}- #{(i+1)*100 -1}", 0]
    end

    num_pages.each do |pages|
      location = (pages / 100)
      data_container[location][1] += 1
    end

    return data_container
  end




end