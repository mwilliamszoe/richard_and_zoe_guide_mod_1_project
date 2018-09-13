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
      puts "Great, you have chosen #{movie.title}."
      # run movie_options method
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

  # def movie_options
    # You can read reviews or create a review. 
    # Would you like to read a review for this movie (y/n)?
    # if "y" run movie_reviews(movie)
    #elsif Would you like to create a review for this movie?
      #if "y" run create_reviews
    #elseif Would you like to choose a new movie?
      #if "y" run movie_choice
    #else Sorry, out of options. Go back to the beginning.
      # run 'run' method
  # end

  # def new_critic
  #   Whats your name?
  #     critic_name = gets.chomp
  #     Critic.create(name: critic_name)
  # end

  # def reviewed_before?
  # Have you reviewed here before(y/n)?
  # if y proceed if no run new_critic 
  # whats your name?
  # input = gets.chomp
  # critics_exists = Critic.find_by(name: name_input)
  # if critics_exists
  # else run new_critic
  # end

  # def create_review(name, title, phrase)
  #   find out which critic is leaving a review
  #     run reviewed_before?
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
