class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :game_id
      t.text :content
      t.string :username
      t.timestamps
    end
    add_index :comments, :game_id
  end
end
