class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :type
      t.integer :category_id
      t.string :title
      t.string :author
      t.string :subject
      t.text :body
      t.float :rating

      t.timestamps
    end
  end
end
