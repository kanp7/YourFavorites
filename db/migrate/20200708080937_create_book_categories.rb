class CreateBookCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :book_categories do |t|

      t.timestamps
    end
  end
end
