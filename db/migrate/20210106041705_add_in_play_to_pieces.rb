class AddInPlayToPieces < ActiveRecord::Migration[6.1]
  def change
    add_column :pieces, :in_play, :boolean, default: true
  end
end
