class AddEmailToTokens < ActiveRecord::Migration[7.1]
  def change
    add_column :tokens, :email, :string
  end
end
