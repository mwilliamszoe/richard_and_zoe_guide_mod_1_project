require 'pry'
ActiveRecord::Base.logger = nil
class Cli

  @@critic = nil

  # def greet
  #   puts "Welcome to The Movie Reviewer! Type in a movie from the list to see more options."
  # end

  # def main_menu
  #   puts "What would you like to do? See our m"
  # end

  def log_in
    puts "Who are you?"
    users_name = gets.chomp
    @@critic = Critic.find_or_create_by(name: users_name)
    movie_choice
  end

  def list_movies
    Movie.all.each do |movie|
      puts "#{movie.id}. #{movie.title}"
    end
  end

  def movie_choice
    puts "Welcome to Movie Town! Select a movie from the list."
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
    puts "Type in the number of your selected option or press 4 to exit the app."
    puts "1. See movie reviews."
    puts "2. Write a review for this movie"
    puts "3. Pick a new movie"
    puts "4. Exit the app"
    n = gets.chomp
   case n
     when 1.to_s
     show_movie_reviews(movie_obj)
     when 2.to_s
      create_review(movie_obj)
     when 3.to_s
       movie_choice
     when 4.to_s
      exit!
     else
      "Sorry not valid input. Please make another selection."
      movie_options(movie_obj)
   end
  end

  def display_reviews(users_movie_obj)
    reviews_arr = users_movie_obj.reviews
    if reviews_arr.empty?
      puts "There are no reviews for this movie."
    else
      reviews_arr.each do |review|
        puts "#{review.id}. #{review.critic.name} said '#{review.phrase}'."
        # puts "#{review.id}. #{review.critic.name} said '#{review.phrase}' about #{review.movie.title}."
      end
    end
  end

  def show_movie_reviews(users_movie_obj)
    display_reviews(users_movie_obj)
    review_options(users_movie_obj)
  end

  def review_options(movie_instance)
    puts "What would you like to do now?"
    puts "1. Edit a review"
    puts "2. Delete a review"
    puts "3. Create a new review"
    puts "4. Pick a new movie"
    puts "5. Exit the app"
    response = gets.chomp
    case response
    when "1"
      puts "Which review? You can simply enter the number next to your chosen review."
      id = gets.chomp.to_i
      change_a_review(id)
    when "2"
      puts "Which review? You can simply enter the number next to your chosen review."
      # puts "#{Review.all.id}.#{Review.all}."
      display_reviews(movie_instance)
      id = gets.chomp.to_i
      delete_a_review(id)
    when "3"
      create_review(movie_instance)
    when "4"
      movie_choice
    when "5"
      exit!
    else
      "Sorry, that choice isn't valid. Please try again."
      review_options
    end
    movie_choice
  end

  def create_review(movie_instance)
    puts "Type in your name please"
    user_name = gets.chomp
    puts "type your review"
    user_review = gets.chomp
    current_critic = Critic.find_or_create_by(name: user_name)
    your_review = Review.create(critic_id: current_critic.id, movie_id: movie_instance.id, phrase: user_review)
    binding.pry
    puts "Great! Your review '#{your_review.phrase}' has been created."
    movie_choice
  end

  def change_a_review(review_id)
    updatable_review = Review.find_by(id: review_id)
    if @@critic == updatable_review.critic
      puts "Here is the current review: '#{updatable_review.phrase}'"
      puts "What would you like the new review to be?"
      user_response = gets.chomp
      updatable_review.phrase = user_response
      updatable_review.save
    else
      puts "Sorry, you do not have authorization to change this review. What would you like to do?"
      puts "1. Log in"
      puts "2. See movies"
      puts "3. Create a new Review"
      user_response = gets.chomp
      case user_response
        when "1"
          log_in
        when "2"
          movie_choice
        when "3"
          create_review(updatable_review.movie)
        else
          puts "Invalid choice. Here is the movie list again :("
          movie_choice
      end
    end
  end 

  def delete_a_review(id)
    Review.find_by(id: id).destroy
    puts "Review with id number #{id} review has been deleted."
    movie_choice
  end

  def run
    # greet
    movie_choice
  end

end
