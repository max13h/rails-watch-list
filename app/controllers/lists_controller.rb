require "open-uri"

class ListsController < ApplicationController
  before_action :list_recover, only: [:show, :destroy]

  def index
    @movies = Movie.all
    @lists = List.all
  end

  def show
    @bookmarks = Bookmark.where(list: @list)
    @bookmark = Bookmark.new
    @review = Review.new
    @reviews = @list.reviews
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    unless @list.banner.attached?
      @list.banner.attach(io: URI.open(Cloudinary::Utils.cloudinary_url("default_background_u8nfrj")), filename: "default_banner.jpg", content_type: "image/jpeg")
    end
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
    params.require(:list).permit(:name, :banner)
  end
end
