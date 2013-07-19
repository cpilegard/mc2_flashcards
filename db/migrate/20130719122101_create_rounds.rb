class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :correct
      t.integer :incorrect
      t.integer :user_id
      t.integer :deck_id
      t.timestamps
    end
  end
end
