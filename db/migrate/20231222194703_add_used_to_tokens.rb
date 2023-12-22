class AddUsedToTokens < ActiveRecord::Migration[7.1]
  def change
    add_column :tokens, :used, :boolean
  end
end
