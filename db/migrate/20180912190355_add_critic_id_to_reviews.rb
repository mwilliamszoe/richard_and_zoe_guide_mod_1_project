class AddCriticIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :critic_id, :integer
  end
end
