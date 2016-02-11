class ReviewsController < ApplicationController
  def create
    @review = current_user.reviews.create(review_params)
    redirect_to :back
  end

  def review_params
    params.require(:review).permit(:message, :rating, :book_id)
  end
end
