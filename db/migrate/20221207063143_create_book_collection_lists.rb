class CreateBookCollectionLists < ActiveRecord::Migration[5.2]
  def change
    create_table :book_collection_lists do |t|
      t.integer :Bookshelf_id
      t.integer :googlebooksid

      t.timestamps
    end
  end
end
