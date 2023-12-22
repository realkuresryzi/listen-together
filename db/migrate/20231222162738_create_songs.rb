class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :dj
      t.integer :upvotes
      t.boolean :played

      t.timestamps
    end
  end
end
