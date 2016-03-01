class PagesController < ApplicationController
  def index
    @books = Book.bestseller(3)
  end

  def shop
    @books = Book.from_category(params[:category]).page(params[:page])
    @categories = Category.all
  end
end
