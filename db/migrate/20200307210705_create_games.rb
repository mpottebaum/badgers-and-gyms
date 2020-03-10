class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :user_name
      t.integer :score
    end
  end
end
