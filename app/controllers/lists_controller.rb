class ListsController < ApplicationController
  def index
    @movies = Movie.all
    @lists = List.all
  end

  def show

  end
end
