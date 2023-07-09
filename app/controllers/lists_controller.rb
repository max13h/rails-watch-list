class ListsController < ApplicationController
  before_action :list_recover, only: [:show]

  def index
    @movies = Movie.all
    @lists = List.all
  end

  def show
    @movies = @list.movies
  end

  private

  def list_recover
    @list = List.find(params[:id])
  end
end
