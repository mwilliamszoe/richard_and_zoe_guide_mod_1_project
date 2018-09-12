Movie.destroy_all
Critic.destroy_all
Review.destroy_all

Critic.create(name: "Jordan")
Movie.create(title: "Jumanji")
Review.create(phrase: "Cinematic Achievement", movie_id:Movie.first.id, critic_id:Critic.first.id)
