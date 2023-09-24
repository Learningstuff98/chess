class CreateEventMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :event_messages do |t|
      t.integer :game_id
      t.text :content, null: false
      t.timestamps
    end
    add_index :event_messages, :game_id
  end
end
