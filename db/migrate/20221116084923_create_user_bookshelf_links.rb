class CreateUserBookshelfLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_bookshelf_links do |t|
      t.integer :user_id
      t.integer :bookshelf_id

      t.timestamps
    end
  end
end
