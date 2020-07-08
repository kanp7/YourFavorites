class CreateBookGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :book_genres do |t|

      t.timestamps
    end
  end
end
