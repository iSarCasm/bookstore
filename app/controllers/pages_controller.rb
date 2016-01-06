class PagesController < ApplicationController
  def index
    @books = Book.page(params[:page])
    @categories = Category.all
  end
end
