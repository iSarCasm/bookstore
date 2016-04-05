class BooksController < ApplicationController
  def show
    @book = Book.friendly.find(params[:id])
    authorize! :show, @book
    @reviews = @book.reviews.where(approved: true) || []
  end
end
