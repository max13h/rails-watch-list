require "json"
require "open-uri"
require "faker"

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

puts "Creating lists..."
puts ""

default_banner = Cloudinary::Utils.cloudinary_url("default_background_u8nfrj")

list0 = List.new(name: "See later")
list0.banner.attach(io: URI.open(default_banner), filename: "default_banner.jpg", content_type: "image/jpeg")
list0.save!
puts "List nb 1 created"
list1 = List.new(name: "Classic movies")
list1.banner.attach(io: URI.open(default_banner), filename: "default_banner.jpg", content_type: "image/jpeg")
list1.save!

puts "List nb 2 created"
list2 = List.new(name: "Superhero")
list2.banner.attach(io: URI.open(default_banner), filename: "default_banner.jpg", content_type: "image/jpeg")
list2.save!

puts "List nb 3 created"
lists = [list0, list1, list2]

puts "Creating reviews to lists..."
puts ""
list_nb = 1 
lists.each do |list|
  nb = 1
  rand(4..10).times do
    Review.create(
      content: Faker::Lorem.paragraph(sentence_count: 1, supplemental: true, random_sentences_to_add: 5),
      rating: rand(1..5),
      list: list
    )
    puts "Creating review nb #{nb} to list #{list_nb}"
    nb += 1
  end
  list_nb += 1
end

puts "Creating movies..."
puts ""

url = "https://tmdb.lewagon.com/movie/popular"
response_serialized = URI.open(url).read
response = JSON.parse(response_serialized)
nb = 0

20.times do 
  movie_tmdb = response["results"][nb]
  poster_url = "https://image.tmdb.org/t/p/w500#{movie_tmdb["poster_path"]}"
  movie = Movie.create!(
    title: movie_tmdb["title"],
    overview: movie_tmdb["overview"],
    poster_url: poster_url,
    rating: movie_tmdb["vote_average"],
  )

  puts "Movie nb #{nb + 1} created"
  nb += 1

  random = rand(3)

  Bookmark.create!(comment: "This is a bookmark!", movie: movie, list: lists[random])
  puts "Movie bookmarked to list #{random}"
  puts ""
end

puts ""
puts "Database succesfully filled!"
