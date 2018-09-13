require 'pry'
ActiveRecord::Base.logger = nil
class Cli
  def greet
    puts "Welcome to The Movie Reviewer! Here are all our movies."
  end

  def list_movies
    Movie.all.each do |movie|
      puts "#{movie.id}. #{movie.title}"
    end
  end

  def movie_choice
    puts "Select a movie from the list."
    movie_input = gets.chomp
    movie = Movie.find_by(title: movie_input)
    if movie
      puts "Great, you have chosen #{movie.title}. Here are the reviews for this movie:..."
      movie_reviews(movie)
    else
      puts "Sorry we don't have that. Type a movie from the list." 
      movie_choice
    end
  end

  def movie_reviews(users_movie_obj)
    reviews_arr = users_movie_obj.reviews
    if reviews_arr.empty?
      puts "its empty"
    else
      reviews_arr.each do |review|
        puts "#{review.critic.name} said '#{review.phrase}' about #{review.movie.title}."
      end
    end
  end

  def run
    greet
    list_movies
    movie_choice
    # movie_reviews
  end

end
