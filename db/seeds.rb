require "json"
require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
m = Movie.count
l = List.count
b = Bookmark.count

puts "There is #{m} movies, #{l} lists and #{b} bookmarks in you database"
puts "Do you want to continue (y/n)"
input = gets.chomp

return if input == "n" || input == "no" || input == "N" || input == "NO"

puts "Clear database..."
puts ""

List.destroy_all
Bookmark.destroy_all
Movie.destroy_all

puts "Database empty"
puts ""

puts "Creating movies..."
puts ""

url = "https://tmdb.lewagon.com/movie/popular"
response_serialized = URI.open(url).read
response = JSON.parse(response_serialized)
nb = 0

20.times do 
  movie_tmdb = response["results"][nb]
  poster_url = "https://image.tmdb.org/t/p/w500#{movie_tmdb["poster_path"]}"
  Movie.create!(
    title: movie_tmdb["title"],
    overview: movie_tmdb["overview"],
    poster_url: poster_url,
    rating: movie_tmdb["vote_average"],
  )

  puts "Movie nb #{nb + 1} created"
  nb += 1
end

puts ""
puts "Database succesfully filled!"
