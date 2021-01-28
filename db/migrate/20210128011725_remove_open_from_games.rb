class RemoveOpenFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :open, :boolean
  end
end
