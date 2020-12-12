class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :chef
      t.references :recipe
      t.boolean :liked, null: false
      t.timestamps null: false
    end
  end
end
