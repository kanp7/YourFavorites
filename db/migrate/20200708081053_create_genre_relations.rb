class CreateGenreRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_relations do |t|
      t.integer :category_id
      t.string :genre_id

      t.timestamps
    end
  end
end
