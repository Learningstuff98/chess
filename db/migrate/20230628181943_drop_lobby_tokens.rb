class DropLobbyTokens < ActiveRecord::Migration[6.1]
  def change
    drop_table :lobby_tokens
  end
end
