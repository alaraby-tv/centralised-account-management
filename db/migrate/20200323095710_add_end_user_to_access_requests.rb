class AddEndUserToAccessRequests < ActiveRecord::Migration[5.2]
  def up
    add_reference :access_requests, :end_user, foreign_key: true
  end

  def down
    remove_reference :access_requests, :end_user, foreign_key: true
  end
end
