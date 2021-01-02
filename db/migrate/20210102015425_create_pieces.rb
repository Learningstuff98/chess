class CreatePieces < ActiveRecord::Migration[6.1]
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y
      t.string :piece_type
      t.string :color
      t.string :icon
      t.timestamps
    end
  end
end
