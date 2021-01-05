class AddDestinationYToPieces < ActiveRecord::Migration[6.1]
  def change
    add_column :pieces, :destination_y, :integer
  end
end
