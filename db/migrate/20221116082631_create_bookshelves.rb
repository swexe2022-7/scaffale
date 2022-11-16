class CreateBookshelves < ActiveRecord::Migration[5.2]
  def change
    create_table :bookshelves do |t|
      t.integer :ISBN
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
