module BooksHelper
  def author_links(authors)
    raw authors.map { |a| link_to a.name, author_path(a) }.join(', ')
  end

  def categories_links(categoires)
    links = categoires.map do |c|
      link_to c.name, index_path(category: c)
    end
    raw links.join(', ')
  end
end
