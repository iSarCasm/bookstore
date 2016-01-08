class PagesController < ApplicationController
  def index
    @books = books_from_category(params[:category]).page(params[:page])
    @categories = Category.all
  end

  private

  def books_from_category(category)
    if category
      Book.joins(:category_books)
        .where("category_books.category_id = ?", category)
    else
      Book.all
    end
  end
end
