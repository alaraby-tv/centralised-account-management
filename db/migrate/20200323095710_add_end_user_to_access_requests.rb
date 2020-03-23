class AddEndUserToAccessRequests < ActiveRecord::Migration[5.2]
  def up
    add_reference :access_requests, :end_user, foreign_key: true
    add_index :access_requests, [:access_account_id, :end_user_id], unique: true
  end

  def down
    remove_reference :access_requests, :end_user
    remove_index :access_requests, [:access_account_id, :end_user_id]
  end
end
