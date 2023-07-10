class ListsController < ApplicationController
  before_action :list_recover, only: [:show, :destroy]

  def index
    @movies = Movie.all
    @lists = List.all
  end

  def show
    @bookmarks = Bookmark.where(list: @list)
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def list_recover
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
