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
    list_movies
    movie_input = gets.chomp
    movie_instance = Movie.find_by(title: movie_input)
    if movie_instance
      movie_options(movie_instance)
    else
      puts "Sorry, we couldn't find this movie. Please try again."
      movie_choice
      end
  end

  def movie_options(movie_obj)
    puts "Type in the number of your selected option"
    puts "1. See movie reviews."
    puts "2. Write a review for this movie"
    puts "3. Pick a new movie"
    n = gets.chomp
   case n
     when 1.to_s
     show_movie_reviews(movie_obj)
     when 2.to_s
      create_review(movie_obj)
     when 3.to_s
       movie_choice
     else
      "Sorry not valid input. Please make another selection."
      movie_options(movie_obj)
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

  def create_review(movie_instance)
    puts "Type in your name please"
    user_name = gets.chomp
    puts "type your review"
    user_review = gets.chomp
    current_critic = Critic.find_or_create_by(name: user_name)
    your_review = Review.create(critic_id: current_critic, movie_id: movie_instance, phrase: user_review)
    puts your_review
  end

  # def
  #   user must be able to update a review that they made
  #   user types in name = gets.chomp
  #   current_critic = Critic.find_or_create_by(name: user_name)
  #   return instance of current critic
  #   loop through reviews of said critic
  #   do current_critic.reviews.
  #   method to edit the string of reviews.phrase???
  # end

  def run
    greet
    movie_choice
  end

end
