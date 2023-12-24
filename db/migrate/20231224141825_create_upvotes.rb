class CreateUpvotes < ActiveRecord::Migration[7.1]
  def change
    create_table :upvotes do |t|
      t.string :token_code
      t.integer :song_id

      t.timestamps
    end
  end
end
