class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string  :answer
      t.string  :question
      t.integer :deck_id
      t.timestamps
    end
  end
end
