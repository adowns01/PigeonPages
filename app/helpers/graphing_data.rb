helpers do

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

  # gets publication yr data and parses for highcharts
  def publication_year_data

    pub_years = get_publication_years();
    min_decade = get_smallest_decade(pub_years);
    max_decade = get_largest_decade(pub_years);

    pub_year_data_container = set_up_data_structure(min_decade, max_decade)

    data = add_pub_year_data(pub_years, pub_year_data_container)

    return data
  end

  def add_pub_year_data(pub_years, pub_year_data_container)
    pub_years.each do |year|
      location = (year % min_decade)/10
      pub_year_data_container[location][1] += 1
    end
  end

  def set_up_data_structure(min_decade, max_decade)
    (((max_decade-min_decade)/10)+1).times do |i|
      data << [(min_decade + i*10).to_s, 0]
    end
  end

  def get_publication_years
    current_user.books.map do |book|
      book.publication_year
    end
  end

  def get_smallest_decade(pub_years)
    (pub_years.min/10)*10
  end

  def get_largest_decade(pub_years)
    (pub_years.max/10)*10
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