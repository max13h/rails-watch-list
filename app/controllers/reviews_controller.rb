class ReviewsController < ApplicationController

  def create
    @list = List.find(params[:id])
    @review = Review.create(review_params)
    @review.list = @list
    if @review.save
      redirect_to list_path(@list)
    else
      show_list_utilities
      render "lists/show", status: :unprocessable_entity
    end
    
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def show_list_utilities
    @bookmarks = Bookmark.where(list: @list)
    @bookmark = Bookmark.new
    @review = Review.new
    @reviews = @list.reviews
    @review.valid?
  end
end
