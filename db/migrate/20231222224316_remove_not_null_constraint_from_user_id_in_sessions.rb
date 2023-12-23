class RemoveNotNullConstraintFromUserIdInSessions < ActiveRecord::Migration[6.0]
  def change
    change_column :sessions, :user_id, :integer, null: true
  end
end
