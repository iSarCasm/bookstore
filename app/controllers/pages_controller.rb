class PagesController < ApplicationController
  def index
    @books = paginate(books_from_category(params[:category]))
    @categories = Category.all
  end

  private

  def books_from_category(category)
    if category
      # wtf i am so bad
      Book.all.preload(:categories).to_a.select do |book|
        book.categories.map(&:id).include? category.to_i
      end
    else
      Book.all
    end
  end

  def paginate(array)
    Kaminari.paginate_array(array).page(params[:page]).per(9)
  end
end
