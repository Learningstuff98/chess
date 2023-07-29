class RemoveIconFromPieces < ActiveRecord::Migration[6.1]
  def change
    remove_column :pieces, :icon, :string
  end
end
