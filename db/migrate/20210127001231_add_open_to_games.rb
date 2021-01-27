class AddOpenToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :open, :boolean, default: true
  end
end
