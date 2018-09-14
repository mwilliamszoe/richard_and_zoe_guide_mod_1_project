Movie.destroy_all
Critic.destroy_all
Review.destroy_all

Critic.create(name: "Jordan")
Critic.create(name: "Zoe")
Critic.create(name: "Richard")

Movie.create(title: "Jumanji")
Movie.create(title: "Saw")
Movie.create(title: "Boyz in da Hood")

Review.create(phrase: "Comedic gold", movie_id:Movie.first.id, critic_id:Critic.first.id)
Review.create(phrase: "Compelling biography", movie_id:Movie.last.id, critic_id:Critic.first.id)
Review.create(phrase: "Absolutely hilarious!", movie_id:Movie.first.id, critic_id:Critic.second.id)
Review.create(phrase: "Terrifying Nightmare!", movie_id:Movie.second.id, critic_id:Critic.last.id)

