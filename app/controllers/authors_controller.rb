class AuthorsController < ApplicationController
  def show
    @author = Author.find_by_id(params[:id])
    error_404 unless @author
  end
end
