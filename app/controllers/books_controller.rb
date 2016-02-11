class BooksController < ApplicationController
  def show
    @book = Book.find_by_id!(params[:id])
    @reviews = @book.reviews.where(approved: true) || []
  end
end
