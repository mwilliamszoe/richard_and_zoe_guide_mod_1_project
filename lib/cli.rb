require 'pry'
ActiveRecord::Base.logger = nil
class Cli

  @@critic = nil
  @@current_movie_instance

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
    @@current_movie_instance = Movie.find_by(title: movie_input)
    if @@current_movie_instance
      movie_options
    else
      puts "Sorry, we couldn't find this movie. Please try again."
      movie_choice
      end
  end

  def movie_options
    puts "Type in the number of your selected option or press 4 to exit the app."
    puts "1. See movie reviews."
    puts "2. Write a review for this movie"
    puts "3. Pick a new movie"
    puts "4. Exit the app"
    n = gets.chomp
   case n
     when 1.to_s
      show_movie_reviews
     when 2.to_s
      create_review
     when 3.to_s
       movie_choice
     when 4.to_s
      exit!
     else
      "Sorry not valid input. Please make another selection."
      movie_options
   end
  end

  def display_reviews
    reviews_arr = @@current_movie_instance.reviews
    if reviews_arr.empty?
      puts "There are no reviews for this movie."
    else
      reviews_arr.each do |review|
        puts "#{review.id}. #{review.critic.name} said '#{review.phrase}'."
        # puts "#{review.id}. #{review.critic.name} said '#{review.phrase}' about #{review.movie.title}."
      end
    end
  end

  def show_movie_reviews
    display_reviews
    review_options
  end

  def which_review
    puts "Which review? You can simply enter the number next to your chosen review."
    gets.chomp.to_i
  end

  def review_options
    puts "What would you like to do now?"
    puts "1. Edit a review"
    puts "2. Delete a review"
    puts "3. Create a new review"
    puts "4. Pick a new movie"
    puts "5. Exit the app"
    response = gets.chomp
    case response
    when "1"
      id = which_review
      change_a_review(id)
    when "2"
      display_reviews
      id = which_review
      delete_a_review(id)
    when "3"
      create_review
    when "4"
      movie_choice
    when "5"
      exit!
    else
      "Sorry, that choice isn't valid. Please try again."
      review_options
    end
  end

  def create_review
    puts "Type in your name please"
    user_name = gets.chomp
    puts "type your review"
    user_review = gets.chomp
    current_critic = Critic.find_or_create_by(name: user_name)
    your_review = Review.create(critic_id: current_critic.id, movie_id: @@current_movie_instance.id, phrase: user_review)
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
      log_in_options
    end
  end


    def log_in_options
      puts "Sorry, you do not have authorization do that. What would you like to do?"
      puts "1. Log in"
      puts "2. See movies"
      puts "3. Create a new Review"
      puts "4. Exit the app"
      user_response = gets.chomp
      case user_response
        when "1"
          log_in
        when "2"
          movie_choice
        when "3"
          create_review
        when "4"
          exit!
        else
          puts "Invalid choice."
          log_in_options
      end
    end 

  def delete_a_review(id)
    destroy_review = Review.find_by(id: id)
    if @@critic == destroy_review.critic
    destroy_review.destroy
    puts "Review with id number #{id} review has been deleted."
    else
      log_in_options
    end
  end

  def run
    # greet
    movie_choice
  end

end
