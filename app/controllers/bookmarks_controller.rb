class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:id])
  end

  def create

    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.where(movie: params[:movie], list: params[:list])
    @bookmark[0].destroy
    redirect_to list_path, status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
