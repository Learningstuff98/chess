class AddDestinationXToPieces < ActiveRecord::Migration[6.1]
  def change
    add_column :pieces, :destination_x, :integer
  end
end
