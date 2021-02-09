class AddWhitesTurnToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :whites_turn, :boolean, default: true
  end
end
