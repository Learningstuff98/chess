class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.boolean :host_as_white, default: true
      t.timestamps
    end
  end
end
