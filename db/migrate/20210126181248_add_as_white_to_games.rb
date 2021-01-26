class AddAsWhiteToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :as_white, :string
  end
end
