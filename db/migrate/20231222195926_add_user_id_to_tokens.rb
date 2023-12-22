class AddUserIdToTokens < ActiveRecord::Migration[7.1]
  def change
    add_reference :tokens, :user, null: false, foreign_key: true
  end
end
