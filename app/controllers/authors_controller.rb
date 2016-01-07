class AuthorsController < ApplicationController
  def show
    @author = Author.find_by_id(params[:id])
    error_404 unless @author
  end

  private

  # wtf
  def error_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
