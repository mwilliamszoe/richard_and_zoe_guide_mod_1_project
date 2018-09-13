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
  end

  def movie_options(movie_obj)
    puts "1. see movie reviews"
    puts "2. write a review"
    puts "3. pick a new movie"
    case n
      when 1
      show_movie_reviews(movie_obj)
      when 2
      #create_review
      "number 2 does nothing"
      when 3
      movie_choice
      end
  end

  def show_movie_reviews(users_movie_obj)
    reviews_arr = users_movie_obj.reviews
    if reviews_arr.empty?
      puts "its empty"
    else
      reviews_arr.each do |review|
        puts "#{review.critic.name} said '#{review.phrase}' about #{review.movie.title}."
      end
    end
  end

  def create_review(movie_choice, phrase)
    puts "Type in your name please"
    user_name = gets.chomp
    
    puts "type your review"
    user_review = gets.chomp
    current_critic = Critic.find_or_create_by(name: user_name)
    your_review = Review.create(current_critic, movie_choice, phrase)
    puts your_review
  end

  # def create_review(title, phrase)
  #   find out which critic is leaving a review
  #     users_name = gets.chomp
  #     Critic.find_by(name: users_name)
  #   create a new review instance
  #     Review.create(name, title, phrase)
  #     review instance must take in an instance of a critic, and a movie that already exists. 
  # end

  def run
    greet
    list_movies
    movie_choice
  end

end
