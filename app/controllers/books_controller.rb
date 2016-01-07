class BooksController < ApplicationController
  def show
    @book = Book.find_by_id(params[:id])
    error_404 unless @book
  end
end
