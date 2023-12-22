class AddDjToSongs < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :dj, :string
  end
end
