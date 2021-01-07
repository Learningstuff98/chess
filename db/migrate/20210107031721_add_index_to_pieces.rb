class AddIndexToPieces < ActiveRecord::Migration[6.1]
  def change
    add_index :pieces, :game_id
  end
end
