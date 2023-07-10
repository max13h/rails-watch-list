class BookmarksController < ApplicationController
  before_action :list_recover, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmarks = Bookmark.where(list: @list)

    movies_list = params[:bookmark][:movie_id]
    all_saved = true

    movies_list.each do |movie_id|
      @bookmark = Bookmark.new(bookmark_params)
      next if movie_id.empty?

      @bookmark.list = @list
      @bookmark.movie = Movie.find(movie_id)
      if @bookmark.save
        next
      else
        all_saved = false
      end
    end

    if all_saved
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.where(movie: params[:movie], list: params[:list])
    @bookmark[0].destroy
    redirect_to list_path, status: :see_other
  end

  private

  def list_recover
    @list = List.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
