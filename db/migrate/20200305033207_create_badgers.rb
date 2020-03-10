class CreateBadgers < ActiveRecord::Migration[6.0]
  def change
    create_table :badgers do |t|
      t.string :name
    end
  end
end
