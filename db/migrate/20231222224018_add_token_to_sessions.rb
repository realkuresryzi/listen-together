class AddTokenToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :token, :string
  end
end
