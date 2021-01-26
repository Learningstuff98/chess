class AddAsBlackToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :as_black, :string
  end
end
