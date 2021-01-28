class CreateLobbyTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :lobby_tokens do |t|
      t.integer :game_id
      t.string :host_username
      t.string :host_color
      t.timestamps
    end
    add_index :lobby_tokens, :game_id
  end
end
