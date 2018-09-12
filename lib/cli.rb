require 'pry'
ActiveRecord::Base.logger = nil
class Cli
  def greet
    puts "Welcome to The Movie Reviewer! "
  end

  def list_movies
    #access all the movies
    # no instances just the title
    #print the title
    Movie.all.each do |movie|
      puts "#{movie.id}. #{movie.title}"
    end
  end

  def movie_choice
    puts "select a movie by number or title"
    movie_input = gets.chomp
    # puts "Here are all the reviews for this movie"
    if movie_input.match(/[0-9]+/)
      puts "its a digit"
    elsif movie_input.match(/[a-zA-Z]+/)
      puts "its a letter"
    end

  end

  def run
    greet
    list_movies
    movie_choice
  end

end
